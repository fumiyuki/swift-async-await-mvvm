//
//  PageDataStore.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

final class PageDataStore {
    func search(query: String) async throws -> [SearchResponse.Page] {
        let request = SearchRequest(query: query)
        return (try await WebAPIClient().send(request: request)).query.search
    }
}
