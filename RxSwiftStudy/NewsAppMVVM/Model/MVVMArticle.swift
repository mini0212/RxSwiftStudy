//
//  Article.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/05/05.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation

struct MVVMArticleResponae: Decodable {
    let articles: [MVVMArticle]
}

struct MVVMArticle: Decodable {
    let title: String
    let description: String?
}
