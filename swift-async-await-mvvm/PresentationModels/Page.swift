//
//  Page.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

struct Page: Identifiable {
    var id: Int {
        pageid
    }
    
    let pageid: Int
    let title: String
    let url: String
}
