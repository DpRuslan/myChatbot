//
//  TopicCoordinator.swift
//

import Foundation
import UIKit

protocol TopicCoordinatorProtocol: AnyObject {
    func goBack()
}

class TopicCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = TopicController()
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopicCoordinator: TopicCoordinatorProtocol {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
