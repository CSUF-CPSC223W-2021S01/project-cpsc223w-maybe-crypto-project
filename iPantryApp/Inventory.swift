//
//  Inventory.swift
//  iPantryApp
//
//  Created by Conner Cook on 5/12/21.
//

import Foundation

struct Inventory {
    var items: [String: Int]
    var totalItems: Int {
        var total = 0
        for (_, num) in items {
            total += num
        }
        return total
    }
    
    init() {
        items = [String: Int]()
    }
    
    mutating func add(_ item: String, quantity: Int) {
        if let oldValue = items.updateValue(quantity, forKey: item) {
            items[item]? += oldValue
        } else {
            items[item] = quantity
        }
    }
}
