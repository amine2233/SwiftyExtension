#if canImport(UIKit)
import UIKit

#if os(iOS)
// MARK: - Methods
extension UISwitch {

    /// SwifterSwift: Toggle a UISwitch
    ///
    /// - Parameter animated: set true to animate the change (default is true)
    public func toggle(animated: Bool = true) {
        setOn(!isOn, animated: animated)
    }

}
#endif

#endif
