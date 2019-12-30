//
//  OWMWeatherTableViewCell.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//


import UIKit
import SDWebImage

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImage: SDAnimatedImageView!
    
    var weatherDetails : ForecastDetailsModel? {
        didSet {
            guard let weatherDetails = weatherDetails else {
                return
            }
            dateLabel?.text = weatherDetails.date.getDateStringFromUTC
            temperatureLabel?.text = weatherDetails.forecastTemperature.temperatureDay.formatAsDegree
            if weatherDetails.Weather.count >= 1 {
                let weather = weatherDetails.Weather[0]
                let iconURL = "\(OWMURL.kWeatherIconURL)\(weather.icon).png"
                iconImage?.sd_setImage(with: URL(string: iconURL), placeholderImage: nil)
            }
        }
    }
}

