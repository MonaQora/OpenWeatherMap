//
//  ServiceResonse.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

enum Response<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ErrorResponse: Error {
    case none
    case network(string: String)
    case custom(string: String)
    case native(string: String)
}

