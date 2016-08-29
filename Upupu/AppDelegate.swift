//
//  AppDelegate.swift
//  Upupu
//
//  Created by Toshiki Takeuchi on 8/29/16.
//  Copyright © 2016 Xcoo, Inc. All rights reserved.
//  See LISENCE for Upupu's licensing information.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupDefaults()
        self.window!.rootViewController = CameraController()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur
        // for certain types of temporary interruptions (such as an incoming phone call or SMS
        // message) or when the user quits the application and it begins the transition to the
        // background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame
        // rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store
        // enough application state information to restore your application to its current state in
        // case it is terminated later.
        // If your application supports background execution, this method is called instead of
        // applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can
        // undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was
        // inactive. If the application was previously in the background, optionally refresh the
        // user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also
        // applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return DropboxUploader.sharedInstance().handleURL(url)
    }

    func setupDefaults() {
        let settingsPath = NSBundle.mainBundle().bundlePath.stringByAppendingString("Settings.bundle")
        let plistPath = settingsPath.stringByAppendingString("Root.inApp.plist")

        if let settingsDictionary = NSDictionary(contentsOfFile: plistPath),
            let preferencesArray = settingsDictionary.objectForKey("PreferenceSpecifiers") as? NSArray {
            let defaults = NSUserDefaults.standardUserDefaults()

            for item in preferencesArray {
                if let v = item as? NSDictionary,
                    let key = v.objectForKey("Key") as? String {
                    let value = defaults.objectForKey(key)
                    let defaultValue = v.objectForKey("DefaultValue")
                    if defaultValue != nil && value == nil {
                        defaults.setObject(defaultValue, forKey: key)
                    }
                }
            }

            defaults.synchronize()
        }
    }

}