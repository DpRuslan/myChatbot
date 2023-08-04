//
//  TextCoordinator.swift
//

import Foundation
import UIKit

protocol TextCoordinatorProtocol: AnyObject {
    var choose: String { get set }
    func showTopic()
    func showNews()
    func imageGeneration()
}

class TextCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    private var shouldChoose: String?
    
    func start() {
        let vc = TextController()
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TextCoordinator: TextCoordinatorProtocol {
    var choose: String {
        get {
            return shouldChoose ?? ""
        }
        set {
            shouldChoose = newValue
        }
    }
    
    func showTopic() {
        let topicCoordinator = TopicCoordinator()
        topicCoordinator.navigationController = navigationController
        topicCoordinator.start()
    }
    
    func showNews() {
        let newsCoordinator = NewsCoordinator()
        newsCoordinator.navigationController = navigationController
        newsCoordinator.start()
    }
    
    func imageGeneration() {
        let imageGenerationCoordinator = ImageGenerationCoordinator()
        imageGenerationCoordinator.navigationController = navigationController
        imageGenerationCoordinator.start()
    }
}
