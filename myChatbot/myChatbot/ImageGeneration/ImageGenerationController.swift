//
//  ImageGenerationController.swift
//

import UIKit
import Combine

class ImageGenerationController: UIViewController {
    var viewModel: ImageGenerationViewModel
    var textFieldView = UIView(frame: .zero)
    var textField = UITextField(frame: .zero)
    private var cancellables: Set<AnyCancellable> = []
    private var topicLabel = UILabel(frame: .zero)
    private var loadingView = UIView(frame: .zero)
    private var indicator = UIActivityIndicatorView(style: .large)
    private var addButton = UIButton(frame: .zero)
    private var sendRequestButton = UIButton(frame: .zero)
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    private  var textFieldBackgroundColor: UIColor {
        UserDefaults.standard.object(forKey: "Theme") as? Int == 0 ?
        UIColor(red: 66/255, green: 91/255, blue: 218/255, alpha: 1) :
        UIColor(red: 232/255, green: 197/255, blue: 71/255, alpha: 1)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = ImageGenerationViewModel()
        
        super.init(nibName: nil, bundle: nil)
        
        setupBinders()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(textFieldView)
        textFieldView.addSubview(textField)
        textFieldView.addSubview(addButton)
        textFieldView.addSubview(sendRequestButton)
        
        setupConstraints()
        addObserverForKeyboard()
    }
    
// MARK: backPressed
    
    @objc func backPressed(_ sender: Any) {
        viewModel.coordinator?.goBack()
    }
}

// MARK: setupBinders

extension ImageGenerationController {
    private func setupBinders() {
        viewModel.eventPubisher.sink { [weak self] event in
            switch event {
            case .update:
                DispatchQueue.main.async {
                    self?.loadingView.removeFromSuperview()
                    self?.tableView.reloadData()
                    self?.textField.isEnabled = true
                    self?.viewModel.scrollTableView()
                    self?.sendRequestButton.isEnabled = true
                }
            case .scroll(let indexPath):
                UIView.animate(withDuration: 0.4) {
                    self?.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    self?.tableView.layoutIfNeeded()
                }
            case .showAlert(let message):
                DispatchQueue.main.async {
                    self?.errorAlert(message: message)
                }
            }
        }.store(in: &cancellables)
    }
}

// MARK: setupUI

extension ImageGenerationController: CustomLabel, CustomView, CustomTextField {
    private func setupUI() {
        topicLabel.text = viewModel.topic
        topicLabel.font = UIFont.systemFont(ofSize: 16)
        
        navigationItem.titleView = topicLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.back, style: .plain, target: self, action: #selector(backPressed(_:)))

        setCustomView(
            view: textFieldView,
            backGroundColor: textFieldBackgroundColor,
            cornerRadius: 0,
            borderColor: .clear,
            borderWidth: 0
        )
        
        setCustomTextField(
            textfield: textField,
            textColor: .black,
            fontSize: 16,
            backGroundColor: .white,
            placeholder: viewModel.placeholderText
        )
        
        textField.delegate = self
        
        addButton.setImage(viewModel.addImage, for: .normal)
        addButton.addTarget(self, action: #selector(newChat(_:)), for: .touchUpInside)
        sendRequestButton.setImage(viewModel.sendRequestImage, for: .normal)
        sendRequestButton.addTarget(self, action: #selector(sendImageRequest(_:)), for: .touchUpInside)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        sendRequestButton.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: setupConstraints

extension ImageGenerationController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: textFieldView.topAnchor, constant: -10),
            
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 110),
            
            addButton.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 15),
            addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            textField.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: sendRequestButton.leadingAnchor, constant: -10),
            
            sendRequestButton.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -15),
            sendRequestButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
        
        addButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        sendRequestButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

// MARK: addObserverForKeyboard

extension ImageGenerationController {
    private func addObserverForKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

// MARK: sendImageRequest

extension ImageGenerationController {
    @objc func sendImageRequest(_ sender: Any) {
        if textField.text != "" {
            viewModel.addItem(item: ImageMessage(isSending: true, text: textField.text!))
            textField.isEnabled = false
            sendRequestButton.isEnabled = false
            tableView.reloadData()
            
            viewModel.imageRequest(prompt: textField.text!)
            viewModel.scrollTableView()
            textField.text = ""
            
            loadingView.frame = view.frame
            indicator.color = .white
            indicator.center = loadingView.center
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            indicator.startAnimating()
            view.addSubview(loadingView)
            loadingView.addSubview(indicator)
        }
    }
    
// MARK: newChat
    
    @objc func newChat(_ sender: Any) {
        newChatAlert(message: viewModel.alertMessage)
    }
}

// MARK: newChatAlert

extension ImageGenerationController {
    private func newChatAlert(message: String) {
        let alertController = UIAlertController(title: "New chat?", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .destructive))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default , handler: { [weak self] _ in
            self?.viewModel.items.removeAll()
            self?.topicLabel.text = self?.viewModel.topic
            self?.tableView.reloadData()
        }))
        
        present(alertController, animated: true)
    }
    
// MARK: errorAlert
    
    private func errorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default , handler: { [weak self] _ in
            self?.loadingView.removeFromSuperview()
            self?.textField.isEnabled = true
            self?.sendRequestButton.isEnabled = true
        }))
        present(alertController, animated: true)
    }
}
