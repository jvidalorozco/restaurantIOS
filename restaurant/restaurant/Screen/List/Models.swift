//
//  Models.swift
//  restaurant
//
//  Created by MacBook Pro on 28/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import Foundation
import CoreLocation

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
    let distance: Double
    let id: String
    
    static var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
    }
    
    var formatterDistance: String? {
        return RestaurantListViewModel.numberFormatter.string(from: distance as NSNumber)
    }
}

extension RestaurantListViewModel {
    init(business: Bussiness) {
        self.name = business.name
        self.id  = business.id
        self.imageUrl = URL(string: business.imageUrl) ?? URL(string: "http://www.google.com")!
        self.distance = (business.distance / 1609.344)
         
    }
}

struct Details: Decodable {
    let price: String
    let phone: String
    let isClosed: Bool
    let rating: Double
    let name: String
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Decodable {
    enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        self.init(latitude: latitude, longitude: longitude)
    }
}
struct DetailsViewModel {
    let price: String
    let isOpen:String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinate: CLLocationCoordinate2D
}

extension DetailsViewModel {
    init(details: Details) {
        self.price = details.price
        self.isOpen = details.isClosed ? "Closed" : "Open"
        self.phoneNumber  = details.phone
        self.rating = "\(details.rating) / 5"
        self.imageUrls = details.photos
        self.coordinate = details.coordinates
    }
}


