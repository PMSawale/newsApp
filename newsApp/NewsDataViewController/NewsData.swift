//
//  NewsData.swift
//  newsApp
//
//  Created by Pankaj Sawale on 03/09/23.
//

import Foundation



struct newsData: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: Source
}
struct Source: Codable {
    let name:String?
}
