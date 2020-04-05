//
//  AppDelegate.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarApperance()
        return true
    }
    
    private func setupNavigationBarApperance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .systemPink
        //UINavigationBar.appearance().barTintColor = .clear
        //UINavigationBar.appearance().isTranslucent = false
        //UINavigationBar.appearance().clipsToBounds = false
        //UINavigationBar.appearance().backgroundColor = .white
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : (UIFont(name: "FONT NAME", size: 18))!, NSForegroundColorAttributeName: UIColor.whiteColor()] }
    }
}

