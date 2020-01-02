//
//  OWMForecastListServiceTests.swift
//  OpenWeatherMapTests
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class OWMForecastListServiceTests: XCTestCase {
    
    private let timeOut = 35.0

    private var service: ForescastListWebServiceProtocol?
    
    override func setUp() {
        super.setUp()
        service = ForescastListWebService()
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }

    func testLoadForecastListAlwaysReturnDataWhenStored() {
        
        let weatherListModel = WeatherListModel.init(forecastList: [ForecastDetailsModel.init(forecastTemperature: TemperatureModel.init(temperatureDay: 13.13, temperatureMorning: 13.13, temperatureEvening: 12.39, temperatureNight: 13.83, temperatureMin: 12.37, temperatureMax: 13.83), date: 1576753200, sunrise: 1576741201, sunset: 1576770900, Weather: [WeatherModel.init(title: "Rain", description: "light rain", icon: "10d")]), ForecastDetailsModel.init(forecastTemperature: TemperatureModel.init(temperatureDay: 11.46, temperatureMorning: 12.68, temperatureEvening: 12.68, temperatureNight: 8.06, temperatureMin: 8.06, temperatureMax: 12.68), date: 1576839600, sunrise: 1576827637, sunset: 1576857321, Weather: [WeatherModel.init(title: "Clouds", description: "light overcast clouds", icon: "04d")])])
        
        let testKey = "TestKey1"
        let cityName = "paris"
        let numDays = 16
        
        LocalStore.storeDataLocally(key: testKey, dataModel: weatherListModel)
        
        let expectation = XCTestExpectation(description: "Sucess load list")
        var listModel: [ForecastDetailsModel]?
        
        service?.loadForecastList(cityName: cityName, days: numDays, localStoreKey: testKey) { list,error in
            expectation.fulfill()
            LocalStore.deleteStoredData(key: testKey)
            listModel = list
        }
        
        wait(for: [expectation], timeout: timeOut)
        XCTAssertNotNil(listModel)
    }
    
    func testLoadForecastListSucessfullyWhenNoErrorsNoStored() {
        let expectation = XCTestExpectation(description: "Sucess load list when no error")
        var responseError:ErrorResponse?
        var listModel: [ForecastDetailsModel]?
        let cityName = "paris"
        let numDays = 16
        
        service?.loadForecastList(cityName: cityName, days: numDays, localStoreKey: nil) { list,error in
            expectation.fulfill()
            listModel = list
            responseError = error
        }
        
        wait(for: [expectation], timeout: timeOut)

        if responseError != nil {
            XCTAssertNil(listModel)
        }
        else {
            XCTAssertNotNil(listModel)
        }
    }
}

