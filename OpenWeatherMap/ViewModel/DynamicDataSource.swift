//
//  DynamicDataSource.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/30/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

class DataSource<T> : NSObject {
    var data: Value<[T]> = Value([])
}

