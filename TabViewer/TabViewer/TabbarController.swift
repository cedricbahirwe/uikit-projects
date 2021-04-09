//
//  TabbarController.swift
//  TabViewer
//
//  Created by Cédric Bahirwe on 09/04/2021.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate, PageViewControllerDelegate {
    
    let selectedColor = UIColor.blue
    let deselectedColor = UIColor.gray
    
    let tabBarImages = [
        UIImage(systemName: "1.circle")!,
        UIImage(systemName: "2.circle")!,
        UIImage(systemName: "3.circle")!
    ]
    
    override func viewDidLoad() {
        
        view.backgroundColor = .gray
        
        self.delegate = self
        tabBar.isTranslucent = true
        tabBar.tintColor = deselectedColor
        tabBar.unselectedItemTintColor = deselectedColor
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
        tabBar.itemSpacing = 10.0
        tabBar.itemWidth = 76.0
        tabBar.itemPositioning = .centered
        
        setUp()
        
        self.selectPage(at: 1)
    }
    
    private func setUp() {
        
        guard let centerPageViewController = createCenterPageViewController() else { return }
        
        var controllers: [UIViewController] = []
        
        controllers.append(createPlaceholderViewController(forIndex: 0))
        controllers.append(centerPageViewController)
        controllers.append(createPlaceholderViewController(forIndex: 2))
        
        setViewControllers(controllers, animated: false)
        
        selectedViewController = centerPageViewController
    }
    
    private func selectPage(at index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
        guard let PageViewController = (self.viewControllers?[1] as? PageViewController) else { return }
        PageViewController.selectPage(at: index)
    }
    
    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = tabbarItem(at: index)
        emptyViewController.view.tag = index
        return emptyViewController
    }
    
    private func createCenterPageViewController() -> UIPageViewController? {
        
        let leftController = CustomViewController()
        let centerController = CustomViewController()
        let rightController = CustomViewController()
        
        leftController.view.tag = 0
        centerController.view.tag = 1
        rightController.view.tag = 2
        
        leftController.view.backgroundColor = .red
        centerController.view.backgroundColor = .blue
        rightController.view.backgroundColor = .yellow
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        guard let pageViewController = storyBoard.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController else { return nil }
        
        pageViewController.pages = [leftController, centerController, rightController]
        pageViewController.tabBarItem = tabbarItem(at: 1)
        pageViewController.view.tag = 1
        pageViewController.swipeDelegate = self
        
        return pageViewController
    }
    
    private func tabbarItem(at index: Int) -> UITabBarItem {
        return UITabBarItem(title: nil, image: self.tabBarImages[index], selectedImage: nil)
    }
    
    private func handleTabbarItemChange(viewController: UIViewController) {
         guard let viewControllers = self.viewControllers else { return }
         let selectedIndex = viewController.view.tag
         self.tabBar.tintColor = selectedColor
         self.tabBar.unselectedItemTintColor = selectedColor
         
         for i in 0..<viewControllers.count {
             let tabbarItem = viewControllers[i].tabBarItem
             let tabbarImage = self.tabBarImages[i]
             tabbarItem?.selectedImage = tabbarImage.withRenderingMode(.alwaysTemplate)
             tabbarItem?.image = tabbarImage.withRenderingMode(
                 i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
             )
         }
         
         if selectedIndex == 1 {
             viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImages[1].withRenderingMode(.alwaysOriginal)
         }
     }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            self.selectPage(at: viewController.view.tag)
            return false
        }
        
        func pageDidSwipe(to index: Int) {
            guard let viewController = self.viewControllers?[index] else { return }
            self.handleTabbarItemChange(viewController: viewController)
        }
}
