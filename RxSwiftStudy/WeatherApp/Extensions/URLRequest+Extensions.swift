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
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in
            if 200..<300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
            
        }.asObservable()
        
    }
        /*
    static func load<T: Decodable>(resource: WeatherResource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> T in
            return try JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
 */
}
