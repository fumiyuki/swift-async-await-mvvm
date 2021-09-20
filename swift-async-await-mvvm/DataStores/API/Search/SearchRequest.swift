//
//  SearchRequest.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

struct SearchRequest: Request {
    typealias Response = SearchResponse
    
    var path: String {
        "/w/api.php"
    }
    
    var method: RequestMethod {
        .get
    }
    
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
