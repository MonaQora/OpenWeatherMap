//
//  OWMForecastListService.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

protocol ForescastListWebServiceProtocol : class {
    func loadForecastList (cityName: String, days: Int, localStoreKey: String?, completion: @escaping ([ForecastDetailsModel]?, ErrorResponse?) -> ())
}

class ForescastListWebService: ForescastListWebServiceProtocol {

    func loadForecastList (cityName: String, days: Int, localStoreKey: String?, completion: @escaping ([ForecastDetailsModel]?, ErrorResponse?) -> ()) {
    
            DispatchQueue.global(qos: .userInitiated).async {
                var url = OWMURL.k16DForecastListURL
                url = url.replacingOccurrences(of: OWMConstant.cityNameKey , with: OWMConstant.parisCityName)
                url = url.replacingOccurrences(of: OWMConstant.numDaysKey , with: String(OWMConstant.numDays16))

                let weatherResource = Resource<WeatherListModel>(url: url) { data in
                    if let weatherModel = try? JSONDecoder().decode(WeatherListModel.self, from: data) {
                        if let localStoreKey = localStoreKey {
                            LocalStore.storeDataLocally(key: localStoreKey, dataModel: weatherModel)
                        }
                        return weatherModel
                    }
                    return nil
                }
                
                ServerClient().load(resource: weatherResource) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let weatherVM) :
                            completion(weatherVM.forecastList, nil)
                        case .failure(let error) :
                            var forecastList: [ForecastDetailsModel]?
                            if let localStoreKey = localStoreKey {
                                if let wetherModel: WeatherListModel = LocalStore.loadDataStored(key: localStoreKey) {
                                    forecastList = wetherModel.forecastList
                                }
                            }
                            completion(forecastList, error)
                        }
                    }
                }
            }
        }

}

