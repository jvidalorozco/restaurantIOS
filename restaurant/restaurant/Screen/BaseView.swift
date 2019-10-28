//
//  BaseView.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

//TODO: Averiguar que es IBDesignable
@IBDesignable class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    func configure(){
        
    }
    
}
