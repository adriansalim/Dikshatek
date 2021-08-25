//
//  AppDelegate.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let homeVc = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeVc)
        navigationController.setNavigationBarHidden(true, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }


}

