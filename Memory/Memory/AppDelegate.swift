//
//  AppDelegate.swift
//  Memory
//
//  Created by Toni Suter on 09/08/16.
//  Copyright © 2016 Toni Suter. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let coreDataStack = CoreDataStack()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        if let nc = window?.rootViewController as? UINavigationController,
            let tvc = nc.topViewController as? MemoryTableViewController {
            tvc.coreDataStack = coreDataStack
        }
        return true
    }
}

