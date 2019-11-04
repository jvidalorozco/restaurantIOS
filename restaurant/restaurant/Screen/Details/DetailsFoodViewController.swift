//
//  DetailsFoodViewController.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {

    @IBOutlet weak var detailsFoodView : DetailsFoodView!
    var viewModel: DetailsViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        if let viewModel = viewModel {
            guard let detailsFoodView = detailsFoodView else { return }
            detailsFoodView.priceLabel.text = viewModel.price
            detailsFoodView.hoursLabel.text = viewModel.isOpen
            detailsFoodView.locationLabel.text = viewModel.phoneNumber
            detailsFoodView.ratingsLabel.text = viewModel.rating
            
            
        }
    }
   
}
