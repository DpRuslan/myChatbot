//
//  NewsDetailViewModel.swift
//

import Foundation

class NewsDetailViewModel {
    var coordinator: NewsDetailCoordinatorProtocol?
    var item: News?
    let back = Model.back
    var title: String {
        item?.title ?? "None"
    }
    
    var description: String {
        item?.description ?? "None"
    }
}
