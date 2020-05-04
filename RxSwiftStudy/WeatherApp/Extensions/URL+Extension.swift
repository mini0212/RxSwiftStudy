//
//  URL+Extension.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/05/04.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation

extension URL {
    static func urlForWeahterAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=d85bcba6f33ed67408c411a42ec7ae8b")
    }
}
