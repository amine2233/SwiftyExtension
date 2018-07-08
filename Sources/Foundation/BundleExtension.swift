#if canImport(Foundation)
import Foundation

extension Bundle {
    var bundleName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }

    var appName: String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }

    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var appEnvironement: String? {
        return infoDictionary?["WCAppName"] as? String
    }
}

#endif
