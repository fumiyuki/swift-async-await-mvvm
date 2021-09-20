# swift-async-await-mvvm

- `Swift` の `async/await` を使った場合のMVVMの実装方法について検討したコード
- Wikipediaの検索APIでページを検索して表示する

### 検証環境
- macOS Big Sur 11.6
- Xcode 13.0(RC版)

### 動作イメージ
<img src="https://github.com/fumiyuki/swift-async-await-mvvm/blob/main/image/screen_shot.png" width="400px">

### [SearchViewModel.swift](https://github.com/fumiyuki/swift-async-await-mvvm/blob/main/swift-async-await-mvvm/Views/SearchView/SearchViewModel.swift)

- `ViewModel` -> `View` は `@Published` を使う
- `View` -> `ViewModel` は `func search() async` などメソッドを呼び出す

```
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
```

### [SearchView.swift](https://github.com/fumiyuki/swift-async-await-mvvm/blob/main/swift-async-await-mvvm/Views/SearchView/SearchView.swift)

- `Task { await viewModel.search() }` でデータ取得

```
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
```