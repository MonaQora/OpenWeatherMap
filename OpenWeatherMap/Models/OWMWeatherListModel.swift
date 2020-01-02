//
//  OWPWeatherListModel.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

struct WeatherListModel: Codable {
    
    let forecastList: [ForecastDetailsModel]
    
    private enum CodingKeys: String, CodingKey, Hashable, CustomStringConvertible {
        case forecastList = "list"
    }

}

struct ForecastDetailsModel: Codable {
    
    let forecastTemperature: TemperatureModel
    let date: Double
    let sunrise: Double
    let sunset: Double
    let Weather: [WeatherModel]
    
    private enum CodingKeys: String, CodingKey {
        case forecastTemperature =  "temp"
        case date = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case Weather = "weather"
    }

}

struct TemperatureModel: Codable {
    
    let temperatureDay: Double
    let temperatureMorning: Double
    let temperatureEvening: Double
    let temperatureNight: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperatureDay = "day"
        case temperatureMorning = "morn"
        case temperatureEvening = "eve"
        case temperatureNight = "night"
        case temperatureMin = "min"
        case temperatureMax = "max"
    }

}

struct WeatherModel: Codable {
    let title: String
    let description: String
    let icon: String

    private enum CodingKeys: String, CodingKey {
        case title = "main"
        case description = "description"
        case icon = "icon"
    }

}

