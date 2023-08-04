//
//  TopicViewModel.swift
//  

import Foundation
import Combine

class TopicViewModel {
    var coordinator: TopicCoordinatorProtocol?
    let topic = Model.topicColor
    let back = Model.back
    let activeSelector = Model.activeSelector
    let selector = Model.selector
    let firstColorSet = Model.firstColorSet
    let secondColorSet = Model.secondColorSet
    let firstTopic = Model.firstTopic
    let secondTopic = Model.secondTopic
    var currentIndex = UserDefaults.standard.object(forKey: "Theme") as? Int == 0 ? 0 : 1
    
    private lazy var items = {[
        Topic(selectorImage: UserDefaults.standard.object(forKey: "Theme") as? Int == 0 ? activeSelector! : selector!, text: firstTopic, colorsSet: firstColorSet!),
        Topic(selectorImage: UserDefaults.standard.object(forKey: "Theme") as? Int == 1 ? activeSelector! : selector!, text: secondTopic, colorsSet: secondColorSet!)
    ]}()
    
    func numbersOf() -> Int {
        items.count
    }
    
    func itemAt(at index: Int) -> Topic {
        items[index]
    }
    
    private let eventSubject = PassthroughSubject<Void, Never>()
    
    var eventPubisher: AnyPublisher<Void, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func didSelectAt(index: Int) {
        if index != currentIndex {
            items[currentIndex].selectorImage = selector!
            items[index].selectorImage = activeSelector!
            currentIndex = index
            UserDefaults.standard.set(index, forKey: "Theme")
            eventSubject.send()
        }
    }
}
