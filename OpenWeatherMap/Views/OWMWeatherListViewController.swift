//
//  OWMWeatherListViewController.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

import UIKit

class WeatherListTableViewController: UITableViewController {

    private var loadingIndicator = UIActivityIndicatorView()
    private let dataSource = WeatherListTableViewDataSource()
    
    lazy var weatherListViewModel : WeatherListViewModel = {
        let viewModel = WeatherListViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupErrorHandling()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupNavigationBar()  {
        self.title = OWMNavigationTitle.forecastListControllerTitle
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadForecastData))
    }
    
    func setupTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self.dataSource
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
            self?.loadingIndicatorStopAnimating()
        }
        
        self.loadForecastData(sender: nil)
        self.loadingIndicatorStartAnimating()
    }
    
    func setupErrorHandling() {
        self.weatherListViewModel.onErrorHandling = { [weak self] error in
            let message: String
            switch error {
            case let .network(string):
                    message = string
            case let .custom (string):
                    message = string
                default:
                    message = error?.localizedDescription ?? OWMMessage.defaultErroeMessage
            }
            
            let controller = UIAlertController(title: OWMError.errorTitle, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: OWMError.colseButtonTitle, style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
            self?.loadingIndicatorStopAnimating()
        }
    }
    
    @objc func loadForecastData(sender: UIButton?) {
        weatherListViewModel.loadParis16DaysForecast()
        self.loadingIndicatorStartAnimating()
    }
    
    func loadingIndicatorStartAnimating() {
        if #available(iOS 13.0, *) {
            loadingIndicator = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
        }
        loadingIndicator.center = CGPoint(x: self.view.frame.width / 2, y: self.tableView.contentOffset.y + self.view.frame.height / 2)
        self.view.addSubview(loadingIndicator)
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    func loadingIndicatorStopAnimating() {
        loadingIndicator.removeFromSuperview()
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
}

//TableView Delegate
extension WeatherListTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
