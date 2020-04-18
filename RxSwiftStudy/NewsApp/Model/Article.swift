//
//  Article.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/18.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation


struct ArticlesList: Decodable {
    let articles: [Article]
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6ab77ef6d5de4aa0bea4b2124f56527b")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String?
}
