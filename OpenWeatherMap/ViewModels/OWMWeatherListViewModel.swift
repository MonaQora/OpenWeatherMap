//
//  OWMWeatherListViewModel.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/30/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    var onErrorHandling : ((ErrorResponse?) -> Void)?
    var dataSource : DynamicDataSource<ForecastDetailsModel>?
    var service: ForescastListWebServiceProtocol?

    init(dataSource : DynamicDataSource<ForecastDetailsModel>?) {
        self.dataSource = dataSource
        self.service = PFForescastListWebService()
    }
    
    func loadParis16DaysForecast()  {

        guard let service = service else {
            onErrorHandling?(ErrorResponse.custom(string: "Missing service"))
            return
        }
        service.loadForecastList(cityName: OWMConstant.parisCityName, days: OWMConstant.numDays16, localStoreKey: OWMKey.k16DForecastList) {result, error in
            DispatchQueue.main.async {
                if let result = result {
                    self.dataSource?.data.value = result
                }
                if let error = error {
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
