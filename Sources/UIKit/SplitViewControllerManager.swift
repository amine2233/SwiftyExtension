#if canImport(UIKit)
import UIKit

#if !os(watchOS) && !os(tvOS)
/// MasterSplitViewController Protocol must adopted by master view in split view
protocol MasterSplitViewController {
    var isCollapseViewController: Bool { get set }
}

/// DetailSplitViewController Protocol must adopted by detail view in split view
protocol DetailSplitViewController {
}

/// SplitViewControllerManagerDataSource is Data source protocol contain detail view or nil
protocol SplitViewControllerManagerDataSource: NSObjectProtocol {
    /**
     Show detail split view contain the detail view or nil
     must implement this if we would like to have split view work correctly with tabbar

     Only use this data source function when rotate split view and isCollapseViewController on master view is true
     */
    func showDetailSplitViewController() -> UIViewController?
}

/// SplitViewControllerManager Class service for mage split view with tabbar view
class SplitViewControllerManager: UISplitViewControllerDelegate {
    /// dataSource viariable
    weak var dataSource: SplitViewControllerManagerDataSource?

    /**
     When its showDetailViewController(_:sender:) method is called, the split view controller calls this method to see if your delegate wants to handle the presentation of the specified view controller. If you implement this method and ultimately return true, your implementation is responsible for presenting the specified view controller in the secondary position of the split view interface.
     If you do not implement this method or if your implementation returns false, the split view controller presents the view controller in an appropriate way.
     */
    public func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender _: Any?) -> Bool {
        guard let tabBarController = (splitViewController.viewControllers.first as? UITabBarController) else { return false }
        guard let navigationController = (tabBarController.selectedViewController as? UINavigationController) else { return false }

        var viewController: UIViewController = vc
        if let showDetailNavigation = vc as? UINavigationController, let topViewController = showDetailNavigation.topViewController {
            viewController = topViewController
        }
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
        return true
    }

    /**
     Use this method to designate the secondary view controller for your split view interface and to perform any additional cleanup that might be needed. After this method returns, the split view controller installs the newly designated primary and secondary view controllers in its viewControllers array.
     When an interface collapses, some view controllers merge the contents of the primary and secondary view controllers. This method is your opportunity to undo those changes and return your split view interface to its original state.
     When you return nil from this method, the split view controller calls the primary view controller’s separateSecondaryViewController(for:) method, giving it a chance to designate an appropriate secondary view controller. Most view controllers do nothing by default but the UINavigationController class responds by popping and returning the view controller from the top of its navigation stack.
     */
    public func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom _: UIViewController) -> UIViewController? {
        guard let tabBarController = (splitViewController.viewControllers.first as? UITabBarController) else { return nil }
        guard let navigationController = (tabBarController.selectedViewController as? UINavigationController) else { return nil }

        if let topViewController = navigationController.topViewController, topViewController is DetailSplitViewController {
            let detailsViewController = navigationController.popViewController(animated: false)
            let navigation = UINavigationController(rootViewController: detailsViewController!)
            return navigation
        }

        return dataSource?.showDetailSplitViewController()
    }

    /**
     This method is your opportunity to perform any necessary tasks related to the transition to a collapsed interface. After this method returns, the split view controller removes the secondary view controller from its viewControllers array, leaving the primary view controller as its only child. In your implementation of this method, you might prepare the primary view controller for display in a compact environment or you might attempt to incorporate the secondary view controller’s content into the newly collapsed interface.
     Returning false tells the split view controller to use its default behavior to try and incorporate the secondary view controller into the collapsed interface. When you return false, the split view controller calls the collapseSecondaryViewController(_:for:) method of the primary view controller, giving it a chance to do something with the secondary view controller’s content. Most view controllers do nothing by default but the UINavigationController class responds by pushing the secondary view controller onto its navigation stack.
     Returning true from this method tells the split view controller not to apply any default behavior. You might return true in cases where you do not want the secondary view controller’s content incorporated into the resulting interface.
     */
    public func splitViewController(_: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryNavigation = secondaryViewController as? UINavigationController else { return false }
        guard let topSecondaryViewController = secondaryNavigation.topViewController, topSecondaryViewController is DetailSplitViewController else { return false }

        guard let tabBarController = primaryViewController as? UITabBarController else { return false }
        guard let viewControllers = tabBarController.viewControllers, !viewControllers.isEmpty else { return false }

        for viewController in viewControllers {
            guard let navigationMastViewController = viewController as? UINavigationController else { continue }
            guard let mastViewController = navigationMastViewController.topViewController as? MasterSplitViewController, mastViewController.isCollapseViewController == false else { continue }

            topSecondaryViewController.hidesBottomBarWhenPushed = true
            navigationMastViewController.pushViewController(topSecondaryViewController, animated: false)
            return true
        }
        return false
    }
}
#endif
#endif
