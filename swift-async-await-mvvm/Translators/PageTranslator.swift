//
//  PageTranslator.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

struct PageTranslator {
    static func translate(page: SearchResponse.Page) -> Page {
        Page(
            pageid: page.pageid,
            title: page.title,
            url: "\(Consts.baseURL)?curid=\(page.pageid)"
        )
    }
}
