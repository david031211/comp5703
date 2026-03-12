//
//  Item.swift
//  comp5703
//
//  Created by 俊杰杨 on 12/3/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
