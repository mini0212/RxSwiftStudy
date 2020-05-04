//
//  WeatherResult.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/25.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    // catchErrorJustReturn 을 사용할 때 디폴트로 리턴할 값을 설정
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
