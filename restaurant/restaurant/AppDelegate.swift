//
//  AppDelegate.swift
//  restaurant
//
//  Created by MacBook Pro on 10/24/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessProvider>()
    let jsonDecoder = JSONDecoder()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        service.request(.search(lat: 42.361145, lon: -71.057083)) { (result) in
            
            switch result {
              case .success(let response):
                let root = try? self.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                if let nav = self.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
              case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
        switch locationService.status {
        case .notDetermined,.denied,.restricted:
            let locationViewController = storyboard.instantiateViewController(identifier: "LocationViewController")
                as? LocationViewController
            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            let nav = storyboard.instantiateViewController(identifier: "RestaurantNavigationController") as? UINavigationController
            window.rootViewController = nav
            loadBusiness()
        }
        window.makeKeyAndVisible()
        return true
    }
    
    
    private func loadBusiness(){
        service.request(.search(lat: 42.361145, lon: -71.057083)) { (result) in
           switch result {
              case .success(let response):
                let root = try? self.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                if let nav = self.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? RestaurantTableViewController {
                    restaurantListViewController.viewModels = viewModels ?? []
                }
              case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    


}

