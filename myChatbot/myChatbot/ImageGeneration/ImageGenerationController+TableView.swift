//
//  ImageGenerationController+TableView.swift
//  

import Foundation
import UIKit

// MARK: UITableViewDataSource

extension ImageGenerationController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.imageMessage = viewModel.itemAt(at: indexPath.row)
        
        return cell
    }
}
