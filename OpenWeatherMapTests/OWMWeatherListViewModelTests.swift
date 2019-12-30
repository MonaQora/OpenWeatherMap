//
//  OWMWeatherListViewModelTests.swift
//  OpenWeatherMapTests
//
//  Created by Mona Qora on 12/30/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class OWMWeatherListViewModelTests: XCTestCase {
    
    var viewModel : WeatherListViewModel!
    private var dataSource : DynamicDataSource<ForecastDetailsModel>! //mackup datasource
    private var service: MockDataService! //mockup service
    private let timeOut = 5.0
    
    override func setUp() {
        super.setUp()
        self.dataSource = DynamicDataSource<ForecastDetailsModel>()
        self.service = MockDataService()
        self.viewModel = WeatherListViewModel.init(dataSource: dataSource)
        self.viewModel.service = service
    }
    
    override func tearDown() {
        super.tearDown()
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
    }
    
    func testNilService() {
        let expectation = XCTestExpectation(description: "Missing service")
        viewModel.service = nil
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        viewModel.loadParis16DaysForecast()
        wait(for: [expectation], timeout: timeOut)
    }
    
    
    func testLoadForecastListFailed () {
        let expectation = XCTestExpectation(description: "Failed load list")
        service.forecastList = nil
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        viewModel.loadParis16DaysForecast()
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testLoadForecastListSucess () {
        let expectation = XCTestExpectation(description: "Sucess load list")
        
        service.forecastList = [ForecastDetailsModel.init(forecastTemperature: TemperatureModel.init(temperatureDay: 20.0, temperatureMorning: 20.0, temperatureEvening: 20.0, temperatureNight: 20.0, temperatureMin: 20.0, temperatureMax: 20.0), date: 1577098800, sunrise: 1577098800, sunset: 1577098800, Weather: [WeatherModel.init(title: "Rain", description: "light rain", icon: "10d")])]
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.loadParis16DaysForecast()
        wait(for: [expectation], timeout: timeOut)
    }
}

fileprivate class MockDataService : ForescastListWebServiceProtocol {
    var forecastList: [ForecastDetailsModel]?
    func loadForecastList(cityName: String, days: Int, localStoreKey: String?, completion: @escaping ([ForecastDetailsModel]?, ErrorResponse?) -> ()) {
        if let forecastList = forecastList {
            completion(forecastList, nil)
        }
        else {
            completion(nil, .custom(string: "Failed fetch data"))
        }
    }
}
