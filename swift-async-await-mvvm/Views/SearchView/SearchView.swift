//
//  SearchView.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("検索ワード", text: Binding(
                        get: { viewModel.output.query },
                        set: { viewModel.queryChanged(query: $0) }
                    ), onCommit:  {
                        // エンター入力で検索
                        Task {
                            await viewModel.search()
                        }
                    })
                    .font(.title)
                }
                
                if !viewModel.output.pages.isEmpty {
                    Section(header: Text("検索結果")) {
                        ForEach(viewModel.output.pages) { page in
                            NavigationLink(destination: WebView(loadUrl: page.url)) {
                                Text(page.title)
                            }
                        }
                    }
                }
            }
            .overlay(
                ProgressView()
                    .opacity(viewModel.output.isLoading ? 1: 0)
            )
            .overlay(
                Text(viewModel.output.error?.message ?? "")
                    .opacity(viewModel.output.error == nil ? 0: 1)
            )
            .navigationTitle(Text("Wikipedia検索"))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
