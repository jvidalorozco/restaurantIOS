//
//  LocationViewController.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var locationView: LocationView!
    var locationService: LocationService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.didTapAllow = { [weak self] in
            self?.locationService?.requestLocationAuthorization()
        }
        
        locationService?.didChangeStatus = {[weak self] success in
            
            if success {
                self?.locationService?.getLocation()
            }
           
        }
        
        locationService?.newLocation = { [weak self] result in
            switch result {
             case .success(let location):
              print(location)
             case .failure(let error):
              assertionFailure("\(error)")
                         
            }
        }
    }
    


}
