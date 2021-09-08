//
//  SearchViewModel.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Combine
import Foundation

enum SearchViewError: Error {
    case searchError
    
    var message: String {
        switch self {
        case .searchError:
            return "検索に失敗しました"
        }
    }
}

@MainActor
final class SearchViewModel: ObservableObject {
    @MainActor
    final class Output: ObservableObject {
        @Published fileprivate(set) var isLoading = false
        @Published fileprivate(set) var pages = [Page]()
        @Published fileprivate(set) var error: SearchViewError?
        @Published fileprivate(set) var query = ""
    }

    let output = Output()
    private let useCase = PageUseCase()

    nonisolated var objectWillChange: ObservableObjectPublisher {
        output.objectWillChange
    }

    func queryChanged(query: String) {
        // バリデーションが必要な場合はここでする
        output.query = query
    }
    
    func search() async {
        output.isLoading = true
        output.pages = [Page]()
        output.error = nil

        defer {
            output.isLoading = false
        }
        
        guard !output.query.isEmpty else {
            // 空文字の場合は空の配列にする
            return
        }

        do {
            output.pages = try await useCase.search(query: output.query)
        } catch {
            output.error = SearchViewError.searchError
        }
    }
}
