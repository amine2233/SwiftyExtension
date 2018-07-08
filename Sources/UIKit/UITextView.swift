#if canImport(UIKit)
import UIKit

#if os(iOS)
extension UITextView {
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set(hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction(_:)))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(_: UIBarButtonItem?) {
        resignFirstResponder()
    }
}

#endif

#endif
