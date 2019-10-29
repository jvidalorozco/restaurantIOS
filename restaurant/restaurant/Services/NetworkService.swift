//
//  NetworkService.swift
//  restaurant
//
//  Created by Administrador on 28/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import Foundation
import Moya


private let apiKey = "JXpKQHmx8z7jr3ACzle7UcdMfaWa20bb-uzRmo87w40IMQuN5BR1cqLRzMxDCsNQTYFEIGzJf4K6CKiljTbX7Ky78XrYNbAF6-4_0gcUg8iravkJk1dVyoezTKO3XXYx"

enum YelpService {
    
    enum BusinessProvider: TargetType {
        case search(lat: Double, lon: Double)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/search"
            }
        }
        var method: Moya.Method {
            return .get
        }
        var sampleData: Data {
            return Data()
        }
        var task: Task {
            switch self {
            case let .search(lat,lon):
                return .requestParameters(parameters: ["latitude": lat, "longitude": lon] , encoding: URLEncoding.queryString)
            }
        }
        var headers: [String : String]? {
            return ["Authorization":"Bearer \(apiKey)"]
        }
      
        
        
    }
}
