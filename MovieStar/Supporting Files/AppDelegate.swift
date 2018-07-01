//
//  AppDelegate.swift
//  MovieStar
//
//  Created by Steven Taglohner on 30/06/2018.
//  Copyright © 2018 Steven Taglohner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = TabBarController()
            window.makeKeyAndVisible()
        }
        return true
    }
}

