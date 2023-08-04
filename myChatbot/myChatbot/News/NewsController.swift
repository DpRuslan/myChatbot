//
//  NewsController.swift
//

import UIKit
import Combine

class NewsController: UIViewController {
    var viewModel: NewsViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var topLabel = UILabel(frame: .zero)
    private var activityIndicator: UIActivityIndicatorView
    private var activityView: UIView
    var tableView = UITableView(frame: .zero, style: .plain)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = NewsViewModel()
        activityView = UIView(frame: .zero)
        activityIndicator = UIActivityIndicatorView(style: .large)
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(activityView)
        activityView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        setupConstraints()
        setupBinder()
        
        viewModel.newsRequest()
    }
    
// MARK: backPressed
    
    @objc func backPressed(_ sender: Any) {
        viewModel.coordinator?.backVC()
    }
}

// MARK: setupUI

extension NewsController {
    private func setupUI() {
        activityView.frame = view.frame
        activityView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        activityIndicator.color = .white
        activityIndicator.center = activityView.center
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        topLabel.text = viewModel.topic
        topLabel.font = UIFont.systemFont(ofSize: 16)
        
        navigationItem.titleView = topLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.back, style: .plain, target: self, action: #selector(backPressed(_:)))
    }
}

// MARK: setupConstraints

extension NewsController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 19),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: setupBinder

extension NewsController {
    private func setupBinder() {
        viewModel.eventPubisher.sink { [weak self] event in
            switch event {
            case .update:
                DispatchQueue.main.async {
                    self?.activityView.removeFromSuperview()
                    self?.tableView.reloadData()
                }
            case .showAlert(let message):
                DispatchQueue.main.async {
                    self?.activityView.removeFromSuperview()
                }
                
                self?.errorAlert(message: message)
            }
        }.store(in: &cancellables)
    }
}

// MARK: errorAlert

extension NewsController {
    private func errorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default , handler: { [weak self] _ in
            self?.viewModel.coordinator?.backVC()
        }))
        
        present(alertController, animated: true)
    }
}
