//
//  melanie.swift
//  iPantry
//
//  Created by Melanie Mach on 3/10/21.
//

import Foundation

//melanie testing


//create a class for Inventory

class Inventory {
    //properties
    var itemName : String
    var itemQuantity : Int
    var itemCategory : String
    
    // could create a dictonary?
    // need more ideas
    //var itemList = [String, Int]
    
    //init
    init() {
        itemName = "Grass"
        itemQuantity = 0
        itemCategory = "Vegetables"
    }
    
    //init to pass in values
    init(itemName : String, itemQuantity : Int, itemCategory : String) {
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        self.itemCategory = itemCategory
    }
    
    func displayQuant() -> String {
        return "There are \(itemQuantity) \(itemName)"
    }
    
    func displayCategory() -> String {
        return "\(itemName) is a \(itemCategory) product."
    }
}


