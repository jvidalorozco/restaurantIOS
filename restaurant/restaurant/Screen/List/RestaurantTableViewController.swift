//
//  RestaurantTableViewController.swift
//  restaurant
//
//  Created by MacBook Pro on 27/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var viewModels = [RestaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableTableViewCell
        
        let vm = viewModels[indexPath.row]
        
        cell.configure(vm)
        
        return cell
    }
    
    

}

