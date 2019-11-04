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
    var navigationController : UINavigationController?
    
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
            self.navigationController = nav
            window.rootViewController = nav
            locationService.getLocation()
            (nav?.topViewController as? RestaurantTableViewController)?.delegate = self
        }
        window.makeKeyAndVisible()
        return true
    }
    
    private func loadDetails(with id: String) {
        service.request(.details(id: id)) { [weak self] (result) in
                   
                   switch result {
                     case .success(let response):
                        guard let strongSelf = self else {return}
                        if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data){
                          let detailsViewModel = DetailsViewModel(details: details)
                            (strongSelf.navigationController?.topViewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                       }
                    case .failure(let error):
                      print("Error: \(error)")
                   }
               }
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


//MARK: Extensions
extension AppDelegate: LocationActions, ListActions {
    func didTapAllow() {
       locationService.requestLocationAuthorization()
    }
    
    func didTapCell(_ viewModel: RestaurantListViewModel) {
        loadDetails(with: viewModel.id)
    }
}
