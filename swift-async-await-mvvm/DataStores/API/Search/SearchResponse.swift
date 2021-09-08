//
//  SearchResponse.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

struct SearchResponse: Decodable {
    struct Query: Decodable {
        let search: [Page]
    }

    struct Page: Decodable {
        let pageid: Int
        let title: String
    }
    
    let query: Query
}
