#if canImport(Foundation)
import Foundation

extension NSDate {
    func toShhort() -> String {
        let formatter = Date.apiShortDateFormatter()
        return formatter.string(from: (self as NSDate) as Date)
    }

    func time() -> String {
        return (self as Date).time()
    }

    func dateWithoutTime() -> Date? {
        return (self as Date).dateWithoutTime()
    }
}

#endif
