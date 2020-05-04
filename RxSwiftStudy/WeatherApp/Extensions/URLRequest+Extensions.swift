//
//  URLRequest+Extensions.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/29.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct WeatherResource<T> {
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable>(resource: WeatherResource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> T in
            return try JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
