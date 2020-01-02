//
//  OWMWeatherDetailsViewController.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherDetailsViewController: UIViewController {

    var weatherDetails: ForecastDetailsModel!
    private var weatherUIDetails = Value(WeatherDetailsUIModel())
    private var weatherDetailsViewModel: WeatherDetailsViewModel!

    @IBOutlet weak var weatherIcon: SDAnimatedImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dayTempLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var morningTempLbl: UILabel!
    @IBOutlet weak var eveningTempLbl: UILabel!
    @IBOutlet weak var nightTempLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDetailsViewModel = WeatherDetailsViewModel.init(weatherDetails: weatherDetails, weatherUIDetails: weatherUIDetails)

        self.weatherUIDetails.addAndNotify(observer: self)  { [weak self] weatherDetails in
            self?.setupViewUI(weatherDetails: weatherDetails)
        }
    }

    func setupViewUI(weatherDetails: WeatherDetailsUIModel) {
        self.weatherIcon.sd_setImage(with: URL(string: weatherDetails.weatherIcon), placeholderImage: nil)
                self.titleLbl.text = weatherDetails.weatherTitle
                self.descriptionLbl.text = weatherDetails.weatherDescription
                self.dateLbl.text = weatherDetails.date
                self.dayTempLbl.text = weatherDetails.dayTemp
                self.maxTempLbl.text = weatherDetails.maxTemp
                self.minTempLbl.text = weatherDetails.minTemp
                self.morningTempLbl.text = weatherDetails.morningTemp
                self.eveningTempLbl.text = weatherDetails.eveningTemp
                self.nightTempLbl.text = weatherDetails.nightTemp
                self.weatherLbl.text = weatherDetails.weather
    }
}

