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
