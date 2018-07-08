#if canImport(NSAppearanceCustomization)
import NSAppearanceCustomization

#if !os(watchOS)
extension NSAppearanceCustomization {
    @discardableResult
    public func style(_ styleClosure: (Self) -> Swift.Void) -> Self {
        styleClosure(self)
        return self
    }
}
#endif

#endif
