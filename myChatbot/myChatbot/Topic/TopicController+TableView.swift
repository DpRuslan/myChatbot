//
//  TopicController+TableView.swift
//

import Foundation
import UIKit

// MARK: UITableViewDataSource

extension TopicController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOf()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.topic = viewModel.itemAt(at: indexPath.row)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension TopicController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectAt(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
