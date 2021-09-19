//
//  AppDelegate.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/07/18.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var socket = SocketIOManager.shared
    
    internal let alertEvent: PublishRelay<Void> = .init()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAzUJW4sz8fVm1soywDJ0VXYEpPQRU0Ubo")
        GMSPlacesClient.provideAPIKey("AIzaSyAzUJW4sz8fVm1soywDJ0VXYEpPQRU0Ubo")
        UNUserNotificationCenter.current().delegate = self
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

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    //앱이 실행중이고 사용자가 알림을 눌렀을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willpresent")
        
        completionHandler([.alert, .badge, .sound])
        
        alertEvent.accept(())
    }
    
    //앱은 백그라운드에 있고 사용자가 알림을 눌렀을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        completionHandler()
    }
    
    
}
