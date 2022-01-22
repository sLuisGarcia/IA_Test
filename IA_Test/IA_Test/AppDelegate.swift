//
//  AppDelegate.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = ViewControllerFactory()
        let rootController = vc.createLoginView()

        self.window?.rootViewController = setNavBar(rootController: rootController)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .none
        self.navController = (application.windows[0].rootViewController as! UINavigationController)
        return true
    }
    
    private func setNavBar(rootController: UIViewController) -> UINavigationController {
        let navController: UINavigationController = UINavigationController(rootViewController: rootController)
        navController.navigationBar.backIndicatorImage = UIImage()
        navController.navigationBar.backIndicatorTransitionMaskImage = UIImage()
//        navController.navigationBar.tintColor = DinnColors.onyx
//        navController.navigationBar.barTintColor = DinnColors.white
        navController.navigationBar.backgroundColor = .clear
        navController.navigationBar.shadowImage = UIImage()
        return navController
    }
}

