//
//  AppDelegate.swift
//  MobilePagoPaChat
//
//  Created by Angelo Cammaroto on 17/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //UIApplication.shared.statusBarStyle = .default
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = UINavigationController(rootViewController: JoinChatViewController())
    window!.makeKeyAndVisible()
    return true
  }
}
