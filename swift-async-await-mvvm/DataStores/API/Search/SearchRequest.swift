//
//  SearchRequest.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

struct SearchRequest: Request {
    typealias Response = SearchResponse
    
    let path: String = "/w/api.php"
    let method: RequestMethod = .get
    
    var queryParameters: [String : String]? {
        [
            "format": "json",
            "action": "query",
            "list": "search",
            "srsearch": query
        ]
    }
    
    let query: String

    init(query: String) {
        self.query = query
    }
}
