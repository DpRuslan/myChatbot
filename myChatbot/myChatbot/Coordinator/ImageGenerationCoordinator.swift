//
//  ImageGenerationCoordinator.swift
// 

import Foundation
import UIKit

protocol ImageGenerationCoordinatorProtocol: AnyObject {
    func backVC()
}

class ImageGenerationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = ImageGenerationController()
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ImageGenerationCoordinator: ImageGenerationCoordinatorProtocol {
    func backVC() {
        navigationController?.popViewController(animated: true)
    }
}
