//
//  NewsCoordinator.swift
//

import Foundation
import UIKit

protocol NewsCoordinatorProtocol: AnyObject {
    func backVC()
    func showDetails(item: News)
}

class NewsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = NewsController()
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsCoordinator: NewsCoordinatorProtocol {
    func backVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func showDetails(item: News) {
        let newsDetailCoordinator = NewsDetailCoordinator()
        newsDetailCoordinator.navigationController = navigationController
        newsDetailCoordinator.item = item
        newsDetailCoordinator.start()
    }
}
