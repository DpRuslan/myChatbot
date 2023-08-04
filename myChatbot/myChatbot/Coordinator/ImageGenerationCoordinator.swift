//
//  ImageGenerationCoordinator.swift
// 

import Foundation
import UIKit

protocol ImageGenerationCoordinatorProtocol: AnyObject {
    func goBack()
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
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
