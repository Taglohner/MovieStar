
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.tabBar.barTintColor = .black
        self.tabBar.tintColor = .white
        self.tabBar.isTranslucent = true
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        let moviesViewController = MoviesViewController()
        moviesViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        
        let viewControllerList = [homeViewController, moviesViewController]
        
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
        viewControllerList.forEach { ($0).tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) }
    }
    
    func animateToTab(toIndex: Int) {
        
        guard let selectedViewController = selectedViewController else { return }
        guard let tabViewControllers = viewControllers else { return }
        guard let fromView = selectedViewController.view else { return }
        guard let toView = tabViewControllers[toIndex].view else { return }
        guard let fromIndex = tabViewControllers.index(of: selectedViewController) else { return }
        guard fromIndex != toIndex else { return }
        
        if let fromView = fromView.superview {
            fromView.addSubview(toView)
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.15, options: .transitionCrossDissolve, completion: nil)
        
//        // Position toView off screen (to the left/right of fromView)
//        let screenWidth = UIScreen.main.bounds.size.width;
//        let scrollRight = toIndex > fromIndex;
//        let offset = (scrollRight ? screenWidth : -screenWidth)
//        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
//
//        // Disable interaction during animation
//        view.isUserInteractionEnabled = false
//
//        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
//
//            // Slide the views by -offset
//            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
//            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
//
//        }, completion: { finished in
//
//            // Remove the old view from the tabbar view.
//            fromView.removeFromSuperview()
//            self.selectedIndex = toIndex
//            self.view.isUserInteractionEnabled = true
//        })
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarViewControllers = tabBarController.viewControllers
        
        guard let index = tabBarViewControllers?.index(of: viewController) else {
            return false
        }
        animateToTab(toIndex: index)
        return true
    }
}

