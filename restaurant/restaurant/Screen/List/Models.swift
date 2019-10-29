//
//  Models.swift
//  restaurant
//
//  Created by MacBook Pro on 28/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import Foundation


struct Root: Codable {
    let businesses: [Bussiness]
}

struct Bussiness: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let distance: Double
}

struct RestaurantListViewModel {
    let name: String
    let imageUrl: URL
    let distance: String
    let id: String
}

extension RestaurantListViewModel {
    init(business: Bussiness) {
        self.name = business.name
        self.id  = business.id
        self.imageUrl = URL(string: business.imageUrl) ?? URL(string: "http://www.google.com")!
        self.distance = "\(business.distance / 1609.344)"
         
    }
}
