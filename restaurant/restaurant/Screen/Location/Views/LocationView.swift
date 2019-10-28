//
//  LocationView.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

@IBDesignable class LocationView: BaseView {
 
    @IBOutlet weak var allowButton  : UIButton!
    @IBOutlet weak var denyButton   : UIButton!
    var didTapAllow: (() -> Void)?
    
    
    @IBAction func allowAction(_ sender: UIButton) {
        didTapAllow?()
     }
    
    @IBAction func denyAction(_ sender: UIButton) {
        
    }
    
 
    
}
