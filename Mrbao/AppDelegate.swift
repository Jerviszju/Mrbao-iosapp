//
//  AppDelegate.swift
//  Mrbao
//
//  Created by jinpeng on 2017/5/2.
//  Copyright © 2017年 金鹏. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var myAuth: MyAuth = MyAuth()
    
    var window: UIWindow?
    
    override init() {
        super.init()
        
        FirebaseApp.configure() // 设置Firebase
        Database.database().isPersistenceEnabled = true // 支持离线
        
        myAuth.addAuthListener()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func login() {
        let emailTxt: String? = UserDefaults.standard.string(forKey: "emailTxt")
        if emailTxt != nil {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let myTabBar = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            window?.rootViewController = myTabBar
        }
    }

    func out() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mySignIn = storyboard.instantiateViewController(withIdentifier: "SignInVC") 
        window?.rootViewController = mySignIn
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
