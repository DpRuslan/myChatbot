//
//  TextController+TableView.swift
//  

import Foundation
import UIKit

// MARK: UITableViewDataSource

extension TextController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.chatMessage = viewModel.itemAt(at: indexPath.row)
        
        return cell
    }
}
