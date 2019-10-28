//
//  AppDelegate.swift
//  restaurant
//
//  Created by MacBook Pro on 10/24/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        switch locationService.status {
        case .notDetermined,.denied,.restricted:
            let locationViewController = storyboard.instantiateViewController(identifier: "LocationViewController")
                as? LocationViewController
            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            assertionFailure()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    


}

