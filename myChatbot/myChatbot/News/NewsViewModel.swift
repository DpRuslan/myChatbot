//
//  NewsViewModel.swift
//

import Foundation
import UIKit
import Combine

struct News {
    var title: String
    var description: String
    var image: UIImage
}

class NewsViewModel {
    enum Event {
        case update
        case showAlert(String)
    }
    
    var coordinator: NewsCoordinatorProtocol?
    let newsAPIManager = APIManager.init(baseURL: .baseURLNews, apiKey: .newsAPIKey)
    let arrowImage = Model.arrowImage!
    let topic = Model.newsTopic
    let back = Model.back
    
    private var items: [News] = []
    
    private let eventSubject = PassthroughSubject<Event, Never>()
    
    var eventPubisher: AnyPublisher<Event, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func eventOccured(type: Event) {
        eventSubject.send(type)
    }
    
    func newsRequest() {
        newsAPIManager.request(endpoint: .everythingURL, method: .GET, parameters: nil) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    self?.items = response.articles.map {News(title: $0.title ?? "None", description: $0.description ?? "None", image: self!.arrowImage)}
                    self?.eventOccured(type: .update)
                } catch {
                    self?.eventOccured(type: .showAlert(CustomError.decodingError.localizedDescription))
                }
            case .failure(let error):
                self?.eventOccured(type: .showAlert(error.localizedDescription))
            }
        }
    }
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func itemAt(at index: Int) -> News {
        items[index]
    }
    
    func didSelectAt(at index: Int) {
        coordinator?.showDetails(item: itemAt(at: index))
    }
}
