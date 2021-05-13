//
//  Inventory.swift
//  iPantryApp
//
//  Created by Conner Cook on 5/12/21.
//

import Foundation

struct InventoryList: Codable {
    var items: [String]
    
    init() {
        items = []
    }
}

struct Inventory {
    var inventory: InventoryList
    
    init() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentsDirectory.appendingPathComponent("inventory").appendingPathExtension("plist")

            let propertyListDecoder = PropertyListDecoder()
            if let retrievedGameHistoryData = try? Data(contentsOf: archiveURL),
               let decodedInventory = try? propertyListDecoder.decode(InventoryList.self, from: retrievedGameHistoryData)
            {
                inventory = decodedInventory
            } else {
                inventory = InventoryList()
            }
        }
    
    mutating func reset() {
        inventory = InventoryList()
    }
    
    func save() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentsDirectory.appendingPathComponent("inventory").appendingPathExtension("plist")

            let propertyListEncoder = PropertyListEncoder()
            let encodedInventory = try? propertyListEncoder.encode(inventory)
            try? encodedInventory?.write(to: archiveURL)
        }
}
