#if canImport(UIKit)
import UIKit

#if !os(watchOS)
extension UIEdgeInsets {
    public enum Position {
        case top
        case left
        case bottom
        case right
    }
}

extension UIButton {
    @discardableResult
    public func border(width: CGFloat, color: UIColor? = nil) -> UIButton {
        style({ button in
            button.layer.borderColor = (color ?? button.tintColor).cgColor
            button.layer.borderWidth = width
        })
        return self
    }

    @discardableResult
    public func corner(radius: CGFloat) -> UIButton {
        style({ button in
            button.layer.cornerRadius = radius
        })
        return self
    }

    @discardableResult
    public func edgeInsets(_ positions: [UIEdgeInsets.Position], value: CGFloat) -> UIButton {
        var tmpPosition = positions

        if tmpPosition.isEmpty {
            tmpPosition = [.bottom, .left, .right, .top]
        }

        for position in tmpPosition {
            switch position {
            case .top:
                contentEdgeInsets.top = value
            case .bottom:
                contentEdgeInsets.bottom = value
            case .left:
                contentEdgeInsets.left = value
            case .right:
                contentEdgeInsets.right = value
            }
        }
        return self
    }
}

// MARK: - Properties
extension UIButton {

    /// SwifterSwift: Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    /// SwifterSwift: Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    /// SwifterSwift: Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    /// SwifterSwift: Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    /// SwifterSwift: Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    /// SwifterSwift: Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable public var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
}

// MARK: - Methods
extension UIButton {

    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    /// SwifterSwift: Set image for all states.
    ///
    /// - Parameter image: UIImage.
    public func setImageForAllStates(_ image: UIImage) {
        states.forEach { self.setImage(image, for: $0) }
    }

    /// SwifterSwift: Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    public func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { self.setTitleColor(color, for: $0) }
    }

    /// SwifterSwift: Set title for all states.
    ///
    /// - Parameter title: title string.
    public func setTitleForAllStates(_ title: String) {
        states.forEach { self.setTitle(title, for: $0) }
    }

    /// SwifterSwift: Center align title text and image on UIButton
    ///
    /// - Parameter spacing: spacing between UIButton title text and UIButton Image.
    public func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

}
#endif

#endif
