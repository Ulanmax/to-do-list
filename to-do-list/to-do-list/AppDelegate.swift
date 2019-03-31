//
//  AppDelegate.swift
//  to-do-list
//
//  Created by Maks Niagolov on 31/03/2019.
//  Copyright © 2019 Maksim Niagolov. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SyncManager.shared.logLevel = .off
        
        return true
    }
    
}

