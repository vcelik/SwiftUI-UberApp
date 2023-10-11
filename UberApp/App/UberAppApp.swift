//
//  UberAppApp.swift
//  UberApp
//
//  Created by Volkan Celik on 08/08/2023.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct UberAppApp: App {
   // @StateObject var locationViewModel=LocationSearchViewModel()
    @StateObject var authViewModel=AuthViewModel()
    @StateObject var homeViewModel=HomeViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //LoginView()
            HomewView()
      //         .environmentObject(locationViewModel)
               .environmentObject(authViewModel)
               .environmentObject(homeViewModel)
        }
    }
}
