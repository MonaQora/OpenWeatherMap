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
    
    var weatherDetailsViewModel: WeatherDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewUI()
    }

    func setupViewUI() {
        self.weatherIcon.sd_setImage(with: URL(string: weatherDetailsViewModel.weatherIconURL), placeholderImage: nil)
        self.titleLbl.text = weatherDetailsViewModel.weatherTitleText
        self.descriptionLbl.text = weatherDetailsViewModel.weatherDescriptionText
        self.dateLbl.text = weatherDetailsViewModel.dateText
        self.dayTempLbl.text = weatherDetailsViewModel.dayTempText
        self.maxTempLbl.text = weatherDetailsViewModel.maxTempText
        self.minTempLbl.text = weatherDetailsViewModel.minTempText
        self.morningTempLbl.text = weatherDetailsViewModel.morningTempText
        self.eveningTempLbl.text = weatherDetailsViewModel.eveningTempText
        self.nightTempLbl.text = weatherDetailsViewModel.nightTempText
        self.weatherLbl.text = weatherDetailsViewModel.weatherText
    }
}

