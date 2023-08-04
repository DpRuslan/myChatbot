//
//  Model.swift
//

import Foundation
import UIKit

struct Model {
    
// MARK: Text
    
    static let topic = "myChatbot"
    static let startText = """
        Welcome to myChatbot. Write something.
        """
    static let placeholderText = "Start typing..."
    static let menuImage = UIImage(named: "menuImage")
    static let addImage = UIImage(named: "addImage")
    static let sendRequestImage = UIImage(named: "sendRequestImage")
    static let alertMessage = """
        Do you want to create new chat?
        """
    static let back = "Back"
    
// MARK: Topic
    
    static let topicColor = "Theme"
    static let activeSelector = UIImage(named: "activeSelector")
    static let selector = UIImage(named: "selector")
    static let firstColorSet = UIImage(named: "firstColorSet")
    static let secondColorSet = UIImage(named: "secondColorSet")
    static let firstTopic = "Theme 1"
    static let secondTopic = "Theme 2"
    
// MARK: News
    
    static let arrowImage = UIImage(named: "arrowImage")
    static let newsTopic = "Fresh News"
    
// MARK: ImageGeneration
    
    static let imageGenerationTopic = "Image Generation"
}
