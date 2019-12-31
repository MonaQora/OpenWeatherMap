//
//  OWMWeatherDetailsViewModelTests.swift
//  OpenWeatherMapTests
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class OWMWeatherDetailsViewModelTests: XCTestCase {

    private var weatherDetailstVM: WeatherDetailsViewModel!
    private var fTemp: TemperatureModel!
    private var fWeather: [WeatherModel]!
    private var fModel: ForecastDetailsModel!
    private var sTemp: TemperatureModel!

    override func setUp() {
        fTemp = TemperatureModel(temperatureDay: 13.13, temperatureMorning: 13.13, temperatureEvening: 12.39, temperatureNight: 13.83, temperatureMin: 12.37, temperatureMax: 13.83)
        sTemp = TemperatureModel(temperatureDay: 26.0, temperatureMorning: 22.0, temperatureEvening: 22.0, temperatureNight: 20.0, temperatureMin: 20.0, temperatureMax: 26.0)

        fWeather = [WeatherModel(title: "Rain", description: "light rain", icon: "10d")]
        fModel = ForecastDetailsModel(forecastTemperature: fTemp, date: 1578308400, sunrise: 1578296601, sunset: 1578326914, Weather: fWeather)
        
        self.weatherDetailstVM = WeatherDetailsViewModel(weatherDetails: fModel)
    }
    
    override func tearDown() {
        weatherDetailstVM = nil
        fTemp = nil
        sTemp = nil
        fModel = nil
        fWeather = nil
    }
    
    func testColdWeather() {
        XCTAssertEqual(self.weatherDetailstVM.weatherDescription(temp: fTemp.temperatureDay), OWMConstant.kCold)
    }

    func testHotWeather() {
        XCTAssertEqual(self.weatherDetailstVM.weatherDescription(temp: sTemp.temperatureDay), OWMConstant.kHot)
    }

    func testViewModelReturnsDataSucessfully() {
        XCTAssertEqual(weatherDetailstVM.dateText, "Jan 6, 2020" )
        XCTAssertEqual(weatherDetailstVM.dayTempText, "13°" )
        XCTAssertEqual(weatherDetailstVM.maxTempText, "14°" )
        XCTAssertEqual(weatherDetailstVM.minTempText, "12°")
        XCTAssertEqual(weatherDetailstVM.morningTempText, "13°")
        XCTAssertEqual(weatherDetailstVM.eveningTempText, "12°")
        XCTAssertEqual(weatherDetailstVM.nightTempText, "14°")
        XCTAssertEqual(weatherDetailstVM.weatherText, "Cold")
        XCTAssertEqual(weatherDetailstVM.weatherIconURL, "https://openweathermap.org/img/w/10d.png")
        XCTAssertEqual(weatherDetailstVM.weatherTitleText, "Rain:")
        XCTAssertEqual(weatherDetailstVM.weatherDescriptionText, "light rain")

    }
}

