//
//  TextViewModel.swift
// 

import Foundation
import UIKit.UIImage
import Combine

class TextViewModel {
    enum Event {
        case update
        case showAlert(String)
        case scroll(IndexPath)
    }
    
    let textAPIManager = APIManager.init(baseURL: .baseURL, apiKey: .textAPIKey)
    var coordinator: TextCoordinatorProtocol?
    var items: [TextMessage] = []
    let startText = Model.startText
    let topic = Model.topic
    let placeholderText = Model.placeholderText
    let menuImage = Model.menuImage
    let addImage = Model.addImage
    let sendRequestImage = Model.sendRequestImage
    let alertMessage = Model.alertMessage
    var firstLaunch = true
    
    private let eventSubject = PassthroughSubject<Event, Never>()
    
    var eventPubisher: AnyPublisher<Event, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func eventOccured(type: Event) {
        eventSubject.send(type)
    }
    
    func changeLaunch() {
        firstLaunch = !firstLaunch
    }
    
    func addItem(item: TextMessage) {
        items.append(item)
    }
    
    func numbersOfItems() -> Int {
        items.count
    }
    
    func itemAt(at index: Int)-> TextMessage {
        items[index]
    }
    
    func textRequest(prompt: String) {
        let body: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": "\(prompt)",
            "max_tokens": 1400
        ]
        
        textAPIManager.request(endpoint: .textURL, method: .POST, parameters: body) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TextResponse.self, from: data)
                    self?.addItem(item: TextMessage(isSending: false, text: response.choices[0].text.replacingOccurrences(of: "\n\n", with: "")))
                    self?.eventOccured(type: .update)
                } catch {
                    self?.eventOccured(type: .showAlert(CustomError.decodingError.localizedDescription))
                }
            case .failure(let error):
                self?.eventOccured(type: .showAlert(error.localizedDescription))
            }
        }
    }
    
    func scrollTableView() {
        if numbersOfItems() >= 2 {
            let lastRowIndex = numbersOfItems() - 1
            let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
            eventOccured(type: .scroll(lastIndexPath))
        }
    }
    
    func setTheme() {
        if UserDefaults.standard.object(forKey: "Theme") == nil {
            UserDefaults.standard.set(0, forKey: "Theme")
        }
    }
}
