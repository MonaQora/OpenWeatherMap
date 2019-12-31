//
//  OWMWeatherListTableViewDataSource.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

class WeatherListTableViewDataSource : DataSource<ForecastDetailsModel>, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OWMCustomCells.weatherListCellID, for: indexPath) as? WeatherTableViewCell else {
            fatalError("\(OWMCustomCells.weatherListCellID) not found")
        }
        
        cell.weatherDetails = self.data.value[indexPath.row]
        return cell
    }

}

