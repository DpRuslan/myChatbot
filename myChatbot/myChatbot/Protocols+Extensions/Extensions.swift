//
//  Extensions.swift
//  

import Foundation

extension String {
    static let baseURL = "https://api.openai.com/v1"
    static let textURL = "/completions"
    static let imageURL = "/images/generations"
    static let baseURLNews = "https://newsapi.org/v2"
    static let everythingURL = "/everything?q=world&pageSize=10&sortedBy=popularity"
    
    static let textAPIKey = "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"
    static let imageAPIKey = "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"
    static let newsAPIKey = "0534cbe7bd6748f7a22c54a8d4716cc7"
}
