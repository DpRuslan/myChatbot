//
//  Protocols.swift
//  

import Foundation
import UIKit

protocol CustomLabel {
    func setCustomLabel(label: UILabel, title: String, fontSize: CGFloat, textColor: UIColor, numbersOfLines: Int?, alignment: NSTextAlignment?)
}

protocol CustomView {
    func setCustomView(view: UIView, backGroundColor: UIColor, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat)
}

protocol CustomTextField {
    func setCustomTextField(textfield: UITextField, textColor: UIColor, fontSize: CGFloat, backGroundColor: UIColor, placeholder: String)
}

extension CustomLabel {
    func setCustomLabel(label: UILabel, title: String, fontSize: CGFloat, textColor: UIColor,numbersOfLines: Int?, alignment: NSTextAlignment?) {
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.numberOfLines = numbersOfLines ?? 0
        label.textAlignment = alignment ?? .left
    }
}

extension CustomView {
    func setCustomView(view: UIView, backGroundColor: UIColor, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        view.layer.backgroundColor = backGroundColor.cgColor
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
    }
}

extension CustomTextField {
    func setCustomTextField(textfield: UITextField, textColor: UIColor, fontSize: CGFloat, backGroundColor: UIColor, placeholder: String) {
        textfield.textColor = textColor
        textfield.borderStyle = .none
        textfield.font = UIFont.systemFont(ofSize: fontSize)
        textfield.layer.cornerRadius = 10
        textfield.backgroundColor = backGroundColor
        let spacingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        spacingLabel.text = "    "
        textfield.leftView = spacingLabel
        textfield.leftViewMode = .always
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: fontSize) as Any
        ]
        
        let attributedPlaceHolder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textfield.attributedPlaceholder = attributedPlaceHolder
    }
}
