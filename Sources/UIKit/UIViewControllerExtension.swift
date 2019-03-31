#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Properties
extension UIViewController {
    /// Extension: Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
}

extension UIViewController {
    /// SwifterSwift: Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener from all notifications.
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UIViewController {
    /// Extension: LoadingIndicator ViewController
    var loading: UIActivityIndicatorView {
        var indicator = UIActivityIndicatorView()
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        indicator.layer.cornerRadius = 10.0
        indicator.center = view.center
        indicator.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
        indicator.style = UIActivityIndicatorView.Style.white
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }

    /// Loading view controller
    struct LoadingSetting {
        static var loading: UIActivityIndicatorView?
    }

    /**
     Shows a loading indicator and disables user interaction with the app until it is hidden
     */
    public func showModalSpinner() {
        LoadingSetting.loading = loading
        // user cannot interact with the app while the spinner is visible
        if let loading = LoadingSetting.loading {
            view.addSubview(loading)
        }
    }

    /**
     Hides the loading indicator and enables user interaction with the app
     */
    public func hideModalSpinner() {
        LoadingSetting.loading?.stopAnimating()
        LoadingSetting.loading?.removeFromSuperview()
        // user can interact again with the app
    }
}

extension UIViewController {
    /// Extension: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - time: (Optional) TimeInterval to show toas message
    public func toast(title: String, message: String, time: TimeInterval = 1.0) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
    }

    /// Extension: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - actions: (Optional)list of button titles for the alert. Default button i.e "Cancel" will be only shown
    ///   - cancelCompletion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    public func alert(title: String?, message: String?, actions: [UIAlertAction]? = nil, cancelCompletion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:
            .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) -> Void in
            cancelCompletion?(alert)
        })
        alertController.addAction(cancelAction)
        actions?.forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

    /// Extension: Helper method to display an actionSheet on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - actions: (Optional)list of actions buttons for the alert. Default button i.e "Cancel" will only be shown
    ///   - cancelCompletion: (Optional) completion block to be invoked when cancel buttons is tapped.
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    public func alertSheet(title: String?, message: String?, actions: [UIAlertAction]? = nil, cancelCompletion: (() -> Void)? = nil) -> UIAlertController {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:
            .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            cancelCompletion?()
        })
        alertController.addAction(cancelAction)
        actions?.forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}

#endif
#endif
