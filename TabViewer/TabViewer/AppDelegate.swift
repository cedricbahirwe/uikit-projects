//
//  AppDelegate.swift
//  TabViewer
//
//  Created by Cédric Bahirwe on 09/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationController(rootViewController: TabbarController())
        window?.makeKeyAndVisible()
        return true
    }
}
