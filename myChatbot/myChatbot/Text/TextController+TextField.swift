//
//  TextController+TextField.swift
//

import Foundation
import UIKit

// MARK: UITextFieldDelegate

extension TextController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyBoardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(textField.frame, from: textField.superview)
        
        view.frame.origin.y = (convertedTextFieldFrame.origin.y - keyboardTopY + 55) * -1
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
