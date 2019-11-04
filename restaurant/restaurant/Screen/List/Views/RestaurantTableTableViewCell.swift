//
//  RestaurantTableTableViewCell.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with vm: RestaurantListViewModel){
        restaurantImageView.af_setImage(withURL: vm.imageUrl)
        restaurantNameLabel.text = vm.name
        locationLabel.text       =  vm.formatterDistance
        
    }
}
