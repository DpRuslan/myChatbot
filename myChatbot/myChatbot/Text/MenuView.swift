//
//  MenuView.swift
//

import Foundation
import UIKit

protocol MenuViewProtocol: AnyObject {
    func imageGeneration()
    func topic()
    func news()
}

class MenuView {
     weak var delegate: MenuViewProtocol?
        
        private lazy var imageGeneration: UIAction = {
            UIAction(title: "Image Generation" , image: UIImage(systemName: "chevron.right")) { [weak self] _ in
                self?.delegate?.imageGeneration()
            }
        }()
        
        private lazy var topic: UIAction = {
            UIAction(title: "Theme" , image: UIImage(systemName: "chevron.right")) { [weak self] _ in
                self?.delegate?.topic()
            }
        }()
        
        private lazy var news: UIAction = {
            UIAction(title: "Fresh News" , image: UIImage(systemName: "chevron.right")) { [weak self] _ in
                self?.delegate?.news()
            }
        }()

    func getMenu() -> UIMenu {
        return UIMenu(title: "", children: [imageGeneration, topic, news])
    }
}
