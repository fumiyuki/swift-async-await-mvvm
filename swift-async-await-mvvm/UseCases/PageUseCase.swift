//
//  PageUseCase.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

/// ページの検索
///  - 表示用のモデルに変換
///  - 複数のDataStoreからデータを取得(必要な場合)
final class PageUseCase {
    func search(query: String) async throws -> [Page] {
        let dataStore = PageDataStore()
        let responsePages = try await dataStore.search(query: query)
        return responsePages.map(PageTranslator.translate)
    }
}
