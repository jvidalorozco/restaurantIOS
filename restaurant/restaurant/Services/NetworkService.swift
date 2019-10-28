//
//  NetworkService.swift
//  restaurant
//
//  Created by Administrador on 28/10/19.
//  Copyright © 2019 Celeste. All rights reserved.
//

import Foundation
import Moya


private let apiKey = ""

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
