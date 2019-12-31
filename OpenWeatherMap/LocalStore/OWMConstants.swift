//
//  Constants.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

struct OWMKey {
    static let k16DForecastList = "16DForecastList"
    static let kAppKey = "648a3aac37935e5b45e09727df728ac2"
    
}

struct OWMMessage {
    static let networkIssueMessage = "Network not conected"
    static let wrongURLMessage = "Wrong url format"
    static let unidentifiedResponseMessage = "Unidentified response"
    static let noDataMessage = "Somthing went wrong, No data fetched"
    static let defaultErroeMessage = "Somthing went wrong"
}

struct OWMURL {
    static let k16DForecastListURL = "https://api.openweathermap.org/data/2.5/forecast/daily?q=CityName&mode=json&units=metric&cnt=Days&APPID=\(OWMKey.kAppKey)"
    
    static let kWeatherIconURL = "https://openweathermap.org/img/w/"
}

struct OWMConstant {
    static let cityNameKey = "CityName"
    static let numDaysKey = "Days"

    static let parisCityName = "paris"
    static let numDays16 = 16
    
    static let kHot = "Hot"
    static let kCold = "Cold"
    static let kMinHot = 25.0
    static let kMinCold = 10.0
}

struct OWMNavigationTitle {
    static let forecastListControllerTitle = "Paris Forecast"
}

struct OWMError {
    static let errorTitle = "An error occured"
    static let colseButtonTitle = "Close"
}

struct OWMCustomCells {
    static let weatherListCellID = "WeatherCell"
}

struct OWMIdentfier {
    static let forecastListController = "WeatherDetailsView"
}
