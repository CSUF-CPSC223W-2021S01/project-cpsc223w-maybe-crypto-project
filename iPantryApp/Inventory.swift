//
//  Inventory.swift
//  iPantryApp
//
//  Created by Conner Cook on 5/12/21.
//

import Foundation

//Initilize the Inventory list with codable in order to save data
struct InventoryList: Codable {
    var items: [String]
    
    init() {
        items = []
    }
}

//This initlizes the Inventory structure and handles all the save data
struct Inventory {
    var inventory: InventoryList
    
    //Allows the items to be saved
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
    
    //Saves the data to persistent data
    func save() {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentsDirectory.appendingPathComponent("inventory").appendingPathExtension("plist")

            let propertyListEncoder = PropertyListEncoder()
            let encodedInventory = try? propertyListEncoder.encode(inventory)
            try? encodedInventory?.write(to: archiveURL)
        }
}
