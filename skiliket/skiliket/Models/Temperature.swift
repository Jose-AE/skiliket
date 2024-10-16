//
//  Temperature.swift
//  skiliket
//
//  Created by Rosa Palacios on 10/10/24.
//

import Foundation

class Temperature: Identifiable{
    var value:String
    var timeStamp:Date
    init(value: String, timeStamp: Date) {
        self.value = value
        self.timeStamp = timeStamp
    }
}
