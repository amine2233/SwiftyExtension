#if canImport(Foundation)
import Foundation

let defaultFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

/// Date creation with ISO8601 Format iso
public enum ISO8601Format: String {
    case year = "yyyy" // 1997
    case yearMonth = "yyyy-MM" // 1997-07
    case date = "yyyy-MM-dd" // 1997-07-16
    case dateTime = "yyyy-MM-dd'T'HH:mmZ" // 1997-07-16T19:20+01:00
    case dateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ" // 1997-07-16T19:20:30+01:00
    case dateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1997-07-16T19:20:30.45+01:00
    
    init(dateString: String) {
        switch dateString.count {
        case 4:
            self = ISO8601Format(rawValue: ISO8601Format.year.rawValue)!
        case 7:
            self = ISO8601Format(rawValue: ISO8601Format.yearMonth.rawValue)!
        case 10:
            self = ISO8601Format(rawValue: ISO8601Format.date.rawValue)!
        case 22:
            self = ISO8601Format(rawValue: ISO8601Format.dateTime.rawValue)!
        case 25:
            self = ISO8601Format(rawValue: ISO8601Format.dateTimeSec.rawValue)!
        default: // 28:
            self = ISO8601Format(rawValue: ISO8601Format.dateTimeMilliSec.rawValue)!
        }
    }
}

/// Date format Enum
public enum DateFormat {
    case iso8601(ISO8601Format?), custom(String)
}

extension Date {
    static func apiDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }
    
    static func apiShortDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    init(dateString: String) {
        self = Date.apiDateFormatter().date(from: dateString)!
    }
    
    func toShhort() -> String {
        let formatter = Date.apiShortDateFormatter()
        return formatter.string(from: self)
    }
    
    func toApi(withTime time: Bool = false) -> String {
        let formatter = time ? Date.apiDateFormatter() : Date.apiShortDateFormatter()
        return formatter.string(from: self)
    }
    
    func add(with days: Int) -> Date? {
        return NSCalendar.current.date(byAdding: .day, value: days, to: self, wrappingComponents: false)
    }
    
    func time() -> String {
        let calender = Calendar.current
        return String(format: "%d:%d", calender.component(.hour, from: self), calender.component(.minute, from: self))
    }
    
    func dateWithoutTime() -> Date? {
        let calender = Calendar.current
        return calender.dateComponents([.year, .month, .day], from: self).date
    }
}

#endif
