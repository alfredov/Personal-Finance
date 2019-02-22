//
//  AppDelegate.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/20/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = LocalNotificationsController()
        
        var keys = Config()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        TWTRTwitter.sharedInstance().start(
            withConsumerKey: keys.TwitterConsumerkey ?? "",
            consumerSecret: keys.TwitterConsumerSecret ?? ""
        )
        
        FirebaseApp.configure()
        initializeController()
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("An error ocurred during Google Authentication", error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Error trying Signin", error.localizedDescription)
                return
            }
            let pageName = "Main"
            if authResult != nil {
                let mainStoryBoard: UIStoryboard = UIStoryboard(name: pageName, bundle: Bundle.main)
                let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: pageName)
                self.window?.rootViewController = protectedPage
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operation when the user disconnects from app here.
    }
    
    func initializeController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let onBoarding = UserDefaults.standard.value(forKey: "WatchedOnboarding") as? Bool ?? false
        var name = "OnBoarding"
        
        if onBoarding {
            name = "SignIn"
        }
        
        let session = Auth.auth().currentUser != nil
        
        if session {
            name = "Main"
        }
        
        let viewController = UIStoryboard(name: name, bundle: Bundle.main).instantiateInitialViewController()
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        
        let googleAuthentication = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        
        if googleAuthentication {
            return true
        }
        
        let facebookAuthentication = ApplicationDelegate.shared.application(app, open: url, options: options)
        return facebookAuthentication
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let facebookAuthentication = ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        if facebookAuthentication {
            return true
        }
        
        let googleAuthentication = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        return googleAuthentication
    }
    
}

