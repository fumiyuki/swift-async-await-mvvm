//
//  Request.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

enum RequestMethod: String {
    // 一旦GETのみ
    case get = "GET"
}

protocol Request {
    associatedtype Response: Decodable
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryParameters: [String: String]? { get }
    var decoder: JSONDecoder { get }
}

extension Request {
    
    var baseURL: String {
        Consts.baseURL
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func buildRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.invalidRequest(baseURL)
        }
        
        components.path = path
                
        switch method {
        case .get:
            if let queryParameters = queryParameters {
                components.queryItems = queryParameters.map { key, value in
                    URLQueryItem(name: key, value: value)
                }
            }
            
            guard let requestURL = components.url else {
                throw APIError.invalidRequest(baseURL)
            }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = method.rawValue
            
            return request
        }
    }
}
