//
//  TopicController.swift
//

import UIKit
import Combine

class TopicController: UIViewController {
    var viewModel: TopicViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var activityIndicator: UIActivityIndicatorView!
    private var activityView: UIView!
    private var topLabel = UILabel(frame: .zero)
    var tableView = UITableView(frame: .zero, style: .plain)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = TopicViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupConstraints()
        setupBinder()

    }
    
// MARK: backPressed
    
    @objc func backPressed(_ sender: Any) {
        viewModel.coordinator?.previousVC()
    }
}

// MARK: setupUI

extension TopicController {
    private func setupUI() {
        activityView = UIView(frame: view.frame)
        activityView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = activityView.center
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        topLabel.text = viewModel.topic
        topLabel.font = UIFont.systemFont(ofSize: 16)
        
        navigationItem.titleView = topLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.back, style: .plain, target: self, action: #selector(backPressed(_:)))
    }
}

// MARK: setupConstraints

extension TopicController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 19),
            tableView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

// MARK: setupBinder

extension TopicController {
    private func setupBinder() {
        viewModel.eventPubisher.sink { [weak self] _ in
            self?.view.addSubview(self!.activityView)
            self?.activityView.addSubview(self!.activityIndicator)
            self?.activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.activityView.removeFromSuperview()
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
}
