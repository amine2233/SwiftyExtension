#if canImport(Foundation)
import Foundation

extension NSRecursiveLock {
    public convenience init(name: String?) {
        self.init()
        self.name = name
    }
}

public protocol Disposable {
    /// Dispose the signal observation or binding.
    func dispose()

    /// Returns `true` is already disposed.
    var isDisposed: Bool { get }
}

public final class BlockDisposable: Disposable {
    public var isDisposed: Bool {
        return handler == nil
    }

    private var handler: (() -> Void)?
    private let lock = NSRecursiveLock(name: "com.recursiveLock.blockdisposable")

    init(_ handler: @escaping (() -> Void)) {
        self.handler = handler
    }

    public func dispose() {
        lock.lock(); defer { lock.unlock() }
        if let handler = handler {
            self.handler = nil
            handler()
        }
    }
}

public final class CompositeDisposable: Disposable {
    public private(set) var isDisposed: Bool = false
    private var disposables: [Disposable] = []
    private let lock = NSRecursiveLock(name: "com.recursiveLock.blockdisposable")

    public convenience init() {
        self.init([])
    }

    public init(_ disposables: [Disposable]) {
        self.disposables = disposables
    }

    public func add(disposable: Disposable?) {
        guard let disposable = disposable else { return }
        lock.lock(); defer { lock.unlock() }
        if isDisposed {
            disposable.dispose()
        } else {
            disposables.append(disposable)
            disposables = disposables.filter { $0.isDisposed == false }
        }
    }

    public func add(completion: @escaping () -> Disposable?) {
        add(disposable: completion())
    }

    public static func += (left: CompositeDisposable, right: Disposable) {
        left.add(disposable: right)
    }

    public func dispose() {
        lock.lock(); defer { lock.unlock() }
        isDisposed = true
        disposables.forEach { $0.dispose() }
        disposables.removeAll()
    }
}

extension NSObjectProtocol where Self: NSObject {
    public func observe<Value>(_ keyPath: KeyPath<Self, Value>, onChange: @escaping (Value) -> Void) -> Disposable {
        let observation = observe(keyPath, options: [.initial, .new]) { _, change in
            // The guard is because of https://bugs.swift.org/browse/SR-6066
            guard let newValue = change.newValue else { return }
            onChange(newValue)
        }
        return BlockDisposable { observation.invalidate() }
    }

    public func observer<Value>(_ keyPath: KeyPath<Self, Value>, onChange: @escaping (Self, Value) -> Void) -> Disposable {
        let observer = observe(keyPath, options: [.initial, .new]) { _, change in
            // The guard is because of https://bugs.swift.org/browse/SR-6066
            guard let newValue = change.newValue else { return }
            onChange(self, newValue)
        }
        return BlockDisposable { observer.invalidate() }
    }

    public func bind<Value, Target>(_ sourceKeyPath: KeyPath<Self, Value>, to target: Target, at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> Disposable {
        return observe(sourceKeyPath) { target[keyPath: targetKeyPath] = $0 }
    }
}

#endif
