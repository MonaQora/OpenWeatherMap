//
//  ServerClient.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation
import Reachability

/* Usually I'm using ALamofire, but according to that we only need to fetch data without extra functions from ALamofire as authibntication*/

struct Resource<T> {
    let url: String
    let parse: (Data) -> T?
}

class ServerClient {
    
    func load<T>(resource: Resource<T>, completion: @escaping ((Response<T, ErrorResponse>) -> Void)) {

        var weatherURL:URL?
        let reachability = try! Reachability()

        if reachability.connection == .unavailable {
            completion(Response.failure(ErrorResponse.network(string: OWMMessage.networkIssueMessage)))
            return
        }

        if resource.url.isEmpty || (URL(string: resource.url) == nil){
            completion(Response.failure(ErrorResponse.custom(string: OWMMessage.wrongURLMessage)))
            return
        }
        else {
             weatherURL = URL(string: resource.url)!
             let sessionConfig = URLSessionConfiguration.default
             sessionConfig.timeoutIntervalForRequest = 30.0
            sessionConfig.timeoutIntervalForResource = 30.0
             let session = URLSession(configuration: sessionConfig)
            session.dataTask(with: weatherURL!) { data, response, error in
                if let error = error {
                    completion(Response.failure(ErrorResponse.native(string: error.localizedDescription)))
                }
                else if let data = data  {
                    if (resource.parse(data) != nil) {
                        completion(Response.success(resource.parse(data)!))
                    }
                    else {
                        completion(Response.failure(ErrorResponse.custom(string: OWMMessage.unidentifiedResponseMessage)))
                    }
                }
                else {
                    completion(Response.failure(ErrorResponse.custom(string: OWMMessage.noDataMessage)))
                }
                
            }.resume()
        }
    }
    
}

