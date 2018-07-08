#if canImport(Foundation)
import Foundation

extension Bool {
    var toString: String {
        return (self == true) ? "true" : "false"
    }

    func toogle() -> Bool {
        return !self
    }
}

#endif
