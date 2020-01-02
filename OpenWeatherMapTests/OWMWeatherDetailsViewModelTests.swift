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

    var weatherUIDetails = Value(WeatherDetailsUIModel())

    override func setUp() {
        fTemp = TemperatureModel(temperatureDay: 13.13, temperatureMorning: 13.13, temperatureEvening: 12.39, temperatureNight: 13.83, temperatureMin: 12.37, temperatureMax: 13.83)
        sTemp = TemperatureModel(temperatureDay: 26.0, temperatureMorning: 22.0, temperatureEvening: 22.0, temperatureNight: 20.0, temperatureMin: 20.0, temperatureMax: 26.0)

        fWeather = [WeatherModel(title: "Rain", description: "light rain", icon: "10d")]
        fModel = ForecastDetailsModel(forecastTemperature: fTemp, date: 1578308400, sunrise: 1578296601, sunset: 1578326914, Weather: fWeather)
        
        weatherDetailstVM = WeatherDetailsViewModel(weatherDetails: fModel, weatherUIDetails: weatherUIDetails)
    }
    
    override func tearDown() {
        weatherDetailstVM = nil
        fTemp = nil
        sTemp = nil
        fModel = nil
        fWeather = nil
    }

    func testColdWeather() {
        XCTAssertEqual(weatherDetailstVM.weatherDescription(temp: fTemp.temperatureDay), OWMConstant.kCold)
    }

    func testHotWeather() {
        XCTAssertEqual(weatherDetailstVM.weatherDescription(temp: sTemp.temperatureDay), OWMConstant.kHot)
    }

    func testViewModelReturnsDataSucessfully() {
        
        let expectation = XCTestExpectation(description: "Successfully Set UI Model")
        weatherDetailstVM.setUIModelData()
        weatherUIDetails.addAndNotify(observer: self) {weatherDetails in
            expectation.fulfill()
            XCTAssertEqual(weatherDetails.date, "Jan 6, 2020" )
            XCTAssertEqual(weatherDetails.dayTemp, "13°" )
            XCTAssertEqual(weatherDetails.maxTemp, "14°" )
            XCTAssertEqual(weatherDetails.minTemp, "12°")
            XCTAssertEqual(weatherDetails.morningTemp, "13°")
            XCTAssertEqual(weatherDetails.eveningTemp, "12°")
            XCTAssertEqual(weatherDetails.nightTemp, "14°")
            XCTAssertEqual(weatherDetails.weather, "Cold")
            XCTAssertEqual(weatherDetails.weatherIcon, "https://openweathermap.org/img/w/10d.png")
            XCTAssertEqual(weatherDetails.weatherTitle, "Rain:")
            XCTAssertEqual(weatherDetails.weatherDescription, "light rain")
        }
        wait(for: [expectation], timeout: 30.0)
    }
}

