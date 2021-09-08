//
//  APIError.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

enum APIError: Error {
    case invalidRequest(String)
    case invalidStatusCode(Int?)
}
