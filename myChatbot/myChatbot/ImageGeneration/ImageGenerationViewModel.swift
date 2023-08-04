//
//  ImageGenerationViewModel.swift
//  

import Foundation
import Combine
import UIKit

class ImageGenerationViewModel {
    enum Event {
        case update
        case showAlert(String)
        case scroll(IndexPath)
    }
    
    let imageAPIManager = APIManager.init(baseURL: .baseURL, apiKey: .imageAPIKey)
    var coordinator: ImageGenerationCoordinatorProtocol?
    var items: [ImageMessage] = []
    let topic = Model.imageGenerationTopic
    let addImage = Model.addImage
    let sendRequestImage = Model.sendRequestImage
    let placeholderText = Model.placeholderText
    let alertMessage = Model.alertMessage
    let back = Model.back
    
    private let eventSubject = PassthroughSubject<Event, Never>()
    
    var eventPubisher: AnyPublisher<Event, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func addItem(item: ImageMessage) {
        items.append(item)
    }
    
    func numbersOfItems() -> Int {
        items.count
    }
    
    func itemAt(at index: Int)-> ImageMessage {
        items[index]
    }
    
    func eventOccured(type: Event) {
        eventSubject.send(type)
    }
    
    func imageRequest(prompt: String) {
        let body: [String: Any] = [
            "prompt": "\(prompt)",
            "n": Int(2),
            "size": "1024x1024"
        ]
        
        imageAPIManager.request(endpoint: .imageURL, method: .POST, parameters: body) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ImageResponse.self, from: data)
                    self?.addItem(item: ImageMessage(isSending: false, image1: self?.getImageFromUrl(stringUrl: response.data[0].url), image2: self?.getImageFromUrl(stringUrl: response.data[1].url)))
                    self?.eventOccured(type: .update)
                } catch {
                    self?.eventOccured(type: .showAlert(CustomError.decodingError.localizedDescription))
                }
            case .failure(let error):
                self?.eventOccured(type: .showAlert(error.localizedDescription))
            }
        }
    }
    
    func getImageFromUrl(stringUrl: String) -> UIImage? {
        let url = URL(string: stringUrl)
        if let imageData = try? Data(contentsOf: url!) {
            return UIImage(data: imageData)!
        }
        
        return nil
    }
    
    func scrollTableView() {
        if numbersOfItems() >= 2 {
            let lastRowIndex = numbersOfItems() - 1
            let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
            eventOccured(type: .scroll(lastIndexPath))
        }
    }
}
