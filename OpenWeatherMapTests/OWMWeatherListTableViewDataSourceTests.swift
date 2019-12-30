//
//  OWMWeatherListTableViewDataSourceTests.swift
//  OpenWeatherMapTests
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class OWMWeatherListTableViewDataSourceTests: XCTestCase {
    var dataSource : WeatherListTableViewDataSource!
    var weatherList : [ForecastDetailsModel]?
    
    override func setUp() {
        dataSource = WeatherListTableViewDataSource()

        weatherList = [ForecastDetailsModel.init(forecastTemperature: TemperatureModel.init(temperatureDay: 13.13, temperatureMorning: 13.13, temperatureEvening: 12.39, temperatureNight: 13.83, temperatureMin: 12.37, temperatureMax: 13.83), date: 1576753200, sunrise: 1576741201, sunset: 1576770900, Weather: [WeatherModel.init(title: "Rain", description: "light rain", icon: "10d")]), ForecastDetailsModel.init(forecastTemperature: TemperatureModel.init(temperatureDay: 11.46, temperatureMorning: 12.68, temperatureEvening: 12.68, temperatureNight: 8.06, temperatureMin: 8.06, temperatureMax: 12.68), date: 1576839600, sunrise: 1576827637, sunset: 1576857321, Weather: [WeatherModel.init(title: "Clouds", description: "light overcast clouds", icon: "04d")])]
    }

    override func tearDown() {
        dataSource = nil
        weatherList = nil
    }

    func testValueInDataSource() {
        
        dataSource.data.value = weatherList!
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        dataSource.data.value = weatherList!
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? WeatherTableViewCell else {
            XCTAssert(false, "Expected WeatherTableViewCell class")
            return
        }
    }

}
