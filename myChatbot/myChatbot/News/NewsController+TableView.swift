//
//  NewsController+TableView.swift
//

import Foundation
import UIKit

// MARK: UITableViewDataSource

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.item = viewModel.itemAt(at: indexPath.row)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(at: indexPath.row)
    }
}
