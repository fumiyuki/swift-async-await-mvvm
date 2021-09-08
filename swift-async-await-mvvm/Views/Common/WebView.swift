//
//  WebView.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var loadUrl:String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}
