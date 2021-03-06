//
//  OWMWeatherListViewController.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/31/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit

class WeatherListTableViewController: UITableViewController {

    private var loadingIndicator = UIActivityIndicatorView()
    private let dataSource = WeatherListTableViewDataSource()
    private var errorResponse: Value<ErrorResponse>?

    lazy var weatherListViewModel : WeatherListViewModel = {
        errorResponse = Value(.none)
        let viewModel = WeatherListViewModel(dataSource: dataSource, errorResponse: errorResponse)
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
    }
    
    func setupErrorHandling() {
        errorResponse?.addAndNotify(observer: self) {[weak self] error in
            let message: String
            switch error {
            case .none:
                return
            case let .network(string):
                message = string
            case let .custom (string):
                message = string
            default:
                message = error.localizedDescription
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
        loadingIndicator = UIActivityIndicatorView(style: .gray)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deatilsVC = storyboard!.instantiateViewController(withIdentifier: OWMIdentfier.forecastListController) as! WeatherDetailsViewController
        deatilsVC.weatherDetails = dataSource.data.value[indexPath.row]
        self.navigationController?.pushViewController(deatilsVC, animated: true)
    }
}
