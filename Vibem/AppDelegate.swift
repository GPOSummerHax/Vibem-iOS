//
//  AppDelegate.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var rootViewController = AuthViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        rootViewController.sessionManager.application(app, open: url, options: options)
        return true
    }
    
}

