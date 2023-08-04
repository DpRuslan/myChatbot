//
//  NewsDetailCoordinator.swift
//

import Foundation
import UIKit

protocol NewsDetailCoordinatorProtocol: AnyObject {
    func backVC()
}

class NewsDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var item: News?
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = NewsDetailController()
        vc.viewModel.coordinator = self
        vc.viewModel.item = item
        vc.updateUI()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsDetailCoordinator: NewsDetailCoordinatorProtocol {
    func backVC() {
        navigationController?.popViewController(animated: true)
    }
}
