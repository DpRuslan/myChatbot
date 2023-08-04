//
//  NewsDetailController.swift
//

import UIKit

class NewsDetailController: UIViewController {
    var viewModel: NewsDetailViewModel
    private var titleLabel = UILabel(frame: .zero)
    private var descriptionLabel = UILabel(frame: .zero)
    private var scrollView = UIScrollView(frame: .zero)
    private var contentOfScroll = UIView(frame: .zero)
    private var titleText: String?
    private var descriptionText: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = NewsDetailViewModel()

        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentOfScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentOfScroll)
        contentOfScroll.addSubview(titleLabel)
        contentOfScroll.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
// MARK: backPressed
    
    @objc func backPressed(_ sender: Any) {
        viewModel.coordinator?.goBack()
    }
}

// MARK: setupUI

extension NewsDetailController: CustomLabel {
    private func setupUI() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .clear
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        contentOfScroll = UIView(frame: .zero)
        contentOfScroll.backgroundColor = .clear
        
        setCustomLabel(
            label: titleLabel,
            title: viewModel.title,
            fontSize: 18,
            textColor: .black,
            numbersOfLines: 0,
            alignment: nil
        )
        
        setCustomLabel(
            label: descriptionLabel,
            title: viewModel.description,
            fontSize: 16,
            textColor: .black,
            numbersOfLines: 0,
            alignment: nil
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.back, style: .plain, target: self, action: #selector(backPressed(_:)))
    }
    
// MARK: updateUI
    
    func updateUI() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        print(viewModel.description)
    }
}

// MARK: setupConstraints

extension NewsDetailController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentOfScroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            contentOfScroll.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            contentOfScroll.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentOfScroll.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentOfScroll.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            contentOfScroll.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentOfScroll.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentOfScroll.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentOfScroll.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentOfScroll.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentOfScroll.trailingAnchor),
        ])
    }
}

// MARK: scrollViewDidScroll

extension NewsDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}
