//
//  ArticleViewModel.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/05/05.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleTableViewModel {
    let articleVM: [ArticleViewModel]
}

extension ArticleTableViewModel {
    init(_ articles: [MVVMArticle]) {
        self.articleVM = articles.compactMap(ArticleViewModel.init)
    }
}

extension ArticleTableViewModel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articleVM[index]
    }
}

struct ArticleViewModel {
    let article: MVVMArticle
    
    init(_ article: MVVMArticle) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
