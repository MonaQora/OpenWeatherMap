//
//  OWMWeatherDetailsViewModel.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel {
    
    var weatherDetails: ForecastDetailsModel!
    
    init(weatherDetails: ForecastDetailsModel) {
        self.weatherDetails = weatherDetails
        if weatherDetails.Weather.count >= 1 {
            let weather = weatherDetails.Weather[0]
            weatherIconURL = "\(OWMURL.kWeatherIconURL)\(weather.icon).png"
            self.weatherTitleText = "\(weather.title):"
            self.weatherDescriptionText = weather.description
        }
    }
    
    var dateText: String {
        get {
            return weatherDetails.date.getDateStringFromUTC
        }
    }
    
    var dayTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureDay.formatAsDegree
        }
    }
    
    var maxTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMax.formatAsDegree
        }
    }
    
    var minTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMin.formatAsDegree
        }
    }
    
    var morningTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMorning.formatAsDegree
        }
    }
    
    var eveningTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureEvening.formatAsDegree
        }
    }
    
    var nightTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureNight.formatAsDegree
        }
    }
    
    var weatherText: String {
        get {
            return weatherDescription(temp: weatherDetails.forecastTemperature.temperatureDay)
        }
    }
    
    var weatherIconURL:String = ""
    var weatherTitleText:String = ""
    var weatherDescriptionText:String = ""
    
    //To be easly parse any temp maybe added later to baseViewModel to be used at any place
    func weatherDescription(temp: Double) -> String {
        var weatherDescription = OWMConstant.kCold
        if temp > OWMConstant.kMinHot {
            weatherDescription = OWMConstant.kHot
        }
        return weatherDescription
    }
    
}

