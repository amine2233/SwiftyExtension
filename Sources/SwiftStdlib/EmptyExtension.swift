#if canImport(Foundation)
import Foundation

protocol Empty {
    func empty() -> Self
}

extension String: Empty {
    func empty() -> String {
        return ""
    }
}

extension Array: Empty {
    func empty() -> Array {
        return []
    }
}

extension Dictionary: Empty {
    func empty() -> [Key: Value] {
        return Dictionary()
    }
}

extension Int: Empty {
    func empty() -> Int {
        return 0
    }
}

extension Optional where Wrapped: Empty {
    /// Return the value of the Optional or the `default` parameter
    /// - param: The value to return if the optional is empty
    func or(_ empty: Wrapped) -> Wrapped {
        return self ?? empty.empty()
    }
}

#endif
