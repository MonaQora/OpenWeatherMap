//
//  OWMWeatherListViewModel.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/30/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    var dataSource : DataSource<ForecastDetailsModel>?
    var errorResponse: Value<ErrorResponse>?
    var service: ForescastListWebServiceProtocol?

    init(dataSource : DataSource<ForecastDetailsModel>?, errorResponse: Value<ErrorResponse>?) {
        self.dataSource = dataSource
        self.errorResponse = errorResponse
        self.service = ForescastListWebService()
    }
    
    func loadParis16DaysForecast()  {

        guard let service = service else {
            self.errorResponse?.value = ErrorResponse.custom(string: "Missing service")
            return
        }
        service.loadForecastList(cityName: OWMConstant.parisCityName, days: OWMConstant.numDays16, localStoreKey: OWMKey.k16DForecastList) {result, error in
            DispatchQueue.main.async {
                if let result = result {
                    self.dataSource?.data.value = result
                }
                if let error = error {
                    self.errorResponse?.value = error
                }
            }
        }
    }
}
