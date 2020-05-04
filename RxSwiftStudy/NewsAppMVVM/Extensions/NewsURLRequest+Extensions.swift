//
//  URLRequest+Extensions.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/05/05.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct NewsResource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: NewsResource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> T in
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
}
