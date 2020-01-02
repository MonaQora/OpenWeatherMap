//
//  OWMWeatherDetailsViewModel.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel {
    
    private var weatherDetails: ForecastDetailsModel!
    private var weatherUIDetails: Value<WeatherDetailsUIModel>?

    
    init(weatherDetails: ForecastDetailsModel, weatherUIDetails: Value<WeatherDetailsUIModel>) {
        self.weatherDetails = weatherDetails
        self.weatherUIDetails = weatherUIDetails
        setUIModelData()
    }

    func setUIModelData() {
        
        if weatherDetails.Weather.count >= 1 {
            let weather = weatherDetails.Weather[0]
            weatherIconURL = "\(OWMURL.kWeatherIconURL)\(weather.icon).png"
            self.weatherTitleText = "\(weather.title):"
            self.weatherDescriptionText = weather.description
        }
        
        let weatherUIDetailsModel = WeatherDetailsUIModel()
        weatherUIDetailsModel.weatherIcon = self.weatherIconURL
        weatherUIDetailsModel.weatherTitle = self.weatherTitleText
        weatherUIDetailsModel.weatherDescription = self.weatherDescriptionText
        weatherUIDetailsModel.date = self.dateText
        weatherUIDetailsModel.maxTemp = self.maxTempText
        weatherUIDetailsModel.minTemp = self.minTempText
        weatherUIDetailsModel.eveningTemp = self.eveningTempText
        weatherUIDetailsModel.nightTemp = self.nightTempText
        weatherUIDetailsModel.weather = self.weatherText
        weatherUIDetailsModel.dayTemp = self.dayTempText
        weatherUIDetailsModel.morningTemp = self.morningTempText
        
        weatherUIDetails?.value = weatherUIDetailsModel
    }
    
    private var dateText: String {
        get {
            return weatherDetails.date.getDateStringFromUTC
        }
    }
    
    private var dayTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureDay.formatAsDegree
        }
    }
    
    private var maxTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMax.formatAsDegree
        }
    }
    
    private var minTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMin.formatAsDegree
        }
    }
    
    private var morningTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureMorning.formatAsDegree
        }
    }
    
    private var eveningTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureEvening.formatAsDegree
        }
    }
    
    private var nightTempText: String {
        get {
            return weatherDetails.forecastTemperature.temperatureNight.formatAsDegree
        }
    }
    
    private var weatherText: String {
        get {
            return weatherDescription(temp: weatherDetails.forecastTemperature.temperatureDay)
        }
    }
    
    private var weatherIconURL:String = ""
    private var weatherTitleText:String = ""
    private var weatherDescriptionText:String = ""
    
    //To be easly parse any temp maybe added later to baseViewModel to be used at any place
    func weatherDescription(temp: Double) -> String {
        var weatherDescription = OWMConstant.kCold
        if temp > OWMConstant.kMinHot {
            weatherDescription = OWMConstant.kHot
        }
        return weatherDescription
    }
    
}

