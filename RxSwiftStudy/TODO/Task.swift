//
//  Task.swift
//  RxSwiftStudy
//
//  Created by Min on 2020/04/10.
//  Copyright © 2020 min_e. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
