//
//  APIManager.swift
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case POST
    case GET
}

enum TypeRequest: String {
    case JSON
}

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
    case dataError
    case urlSession
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .invalidResponse:
            return "Invalid Response received"
        case .requestFailed(let code):
            let statusCode = StatusCode(rawValue: code) ?? .unknown
            return "\(statusCode.description)"
        case .dataError:
            return "Data error occurred"
        case .urlSession:
            return "Missing Internet connection!"
        case .decodingError:
            return "Error decoding"
        }
    }
}

enum StatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case plan = 426
    case tooManyRequests = 429
    case serverError = 500
    case overLoaded = 503
    case unknown
    
    var description: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to a missing or misconfigured parameter."
        case .unauthorized:
            return "Your API key was missing from the request, or wasn't correct."
        case .plan:
            return "You are trying to request results too far in the past. Your plan permits you to request articles as far back as 2023-06-29"
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while."
        case .serverError:
            return "Server Error - Something went wrong on our side."
        case .overLoaded:
            return "The engine is currently overloaded, please try again later"
        case .unknown:
            return "Unknown"
        }
    }
}

class APIManager {
    let baseURL: String
    let apiKey: String
    
    init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func request(endpoint: String, method: HTTPMethod, parameters: [String: Any]?, completion: @escaping (Result<Foundation.Data, CustomError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        } else {
            request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        }
       
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(.failure(.urlSession))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.requestFailed(httpResponse.statusCode)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.dataError))
            }
        }
        
        task.resume()
    }
}
