//
//  AppDelegate.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 15.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit
import SwiftyVK
import SideMenuController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vkDelegate: VKDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Изменение цвета и шрифта navigationBar
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 18)!]
        UINavigationBar.appearance().barTintColor = Styles.navigationBarBackground
        
        vkDelegate = VKAPIManager()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VK.process(url: url, sourceApplication: app)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

