//
//  AppDelegate.swift
//  OpenCamera
//
//  Created by florian BUREL on 04/04/2020.
//  Copyright © 2020 f10.solutions. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {

    var window: UIWindow?;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
    
        self.window = UIWindow(frame: UIScreen.main.bounds)
        initCrashAnalytics();
        commonStart()
        
        return true
    }

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
               if let windowScene = scene as? UIWindowScene {
                   self.window = UIWindow(windowScene: windowScene)
                   commonStart()
               }
    }
    
    func initCrashAnalytics(){
        if let secret = ProcessInfo.processInfo.environment["APP_CENTER_SECRET"] {
            print("secret id \(secret)");
            AppCenter.start(withAppSecret: "c496a455-116c-44ad-8b16-255a43544097", services:[
              Analytics.self,
              Crashes.self
            ])
        }
    }
    
    func commonStart() {
        let mainViewController = ViewController()
        self.window!.rootViewController = mainViewController
        self.window!.makeKeyAndVisible()
        UIApplication.shared.isIdleTimerDisabled = true
    }
}

