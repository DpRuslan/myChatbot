//
//  APIModel.swift
//

import Foundation

struct EndPoints {
    static let baseURL = "https://api.openai.com/v1"
    static let textURL = "/completions"
    static let imageURL = "/images/generations"
}

struct TextResponse: Decodable {
    let choices: [Choices]
}

struct Choices: Decodable {
    let text: String
    let finish_reason: String
}

struct ImageResponse: Decodable {
    let data: [ImageURLS]
}

struct ImageURLS: Decodable {
    let url: String
}

struct Response: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Decodable {
    let name: String?
}

