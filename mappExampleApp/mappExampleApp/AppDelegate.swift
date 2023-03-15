//
//  AppDelegate.swift
//  mappExampleApp
//
//  Created by Stefan Stevanovic on 13/05/2020.
//  Copyright © 2020 Stefan Stevanovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppoxeeNotificationDelegate, AppoxeeInappDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Appoxee.shared()?.engageAndAutoIntegrate(launchOptions: launchOptions, andDelegate: self, with: .EMC_US)
        AppoxeeInapp.shared()?.engage(with: self, with: .eMC_US)
        Appoxee.shared()?.saveUserNotificationCategory([shopPromotionsCategory, fixItPromotionsCategory, cityFixItNewsCategory, countryFixItNewsCategory])
        
        UNUserNotificationCenter.current().delegate = self
UNUserNotificationCenter.current().requestAuthorization(: [.alert, .badge, .sound], completionHandler: {_, _ in })
application.registerForRemoteNotifications()

let CUSTOM_ACTION1 = UNNotificationAction(identifier: "view_now", title: "CUSTOM_ACTION_TITLE", options: .foreground)

let CUSTOM_ACTION2 = UNNotificationAction(identifier: "skip", title: "CUSTOM_ACTION2_TITLE", options: .foreground)

let CUSTOM_CATEGORY = UNNotificationCategory(identifier: " CUSTOM_CATEGORY_NAME", actions: [CUSTOM_ACTION1, CUSTOM_ACTION2], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)

let notificationCenter = UNUserNotificationCenter.current()
notificationCenter.setNotificationCategories([CUSTOM_CATEGORY])
        
Appoxee.shared()?.saveUserNotificationCategory([CUSTOM_CATEGORY])
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func appoxee(_ appoxee: Appoxee, handledRemoteNotification pushNotification: APXPushNotification, andIdentifer actionIdentifier: String) {
        print(pushNotification);
        if let deepLink = pushNotification.extraFields?["apx_dpl"] {
            _ = application(app: UIApplication.shared, openURL: NSURL(string: deepLink as! String) ?? NSURL(), options: [:])
        }
    }
    
    private func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
         
        handleScheme(scheme: url)
         
        return true
    }
    
    func handleScheme(scheme: NSURL) {
         
        if scheme.scheme?.elementsEqual("deeplinkScheme") ?? false {
//            You can use any of this to make more action with your deeplink
//            scheme.relativePath
//            scheme.parameterString
//            scheme.query
            guard let host =  scheme.host else { return}
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let obj = storyboard.instantiateViewController(withIdentifier: host)
            self.window?.rootViewController = obj
            self.window?.makeKeyAndVisible()
        }
    }


}

