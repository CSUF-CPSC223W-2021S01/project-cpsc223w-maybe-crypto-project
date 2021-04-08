//
//  ethan.swift
//  iPantry
//
//  Created by Ethan Bartlett on 4/7/21.
//

import Foundation

struct FoodData {
    static var food_data:[String:(Int,String, UIImage?)] = [:]
}

class FoodItem {
    var ID: String
    var name: String
    var timestamp: Int
    
    init(id: String, n: String, t: Int) {
        ID = id
        name = n
        timestamp = t
    }
    
    static func ==(lhs: FoodItem, rhs: FoodItem) -> Bool {
        return (lhs.ID == rhs.ID)
    }
}

class FoodList {
    var name: String?
    var contents: [FoodItem] = []
    
    func clear() {
        name = nil
        contents.removeAll()
    }
}

class ListItem {
    var ID: String
    var name: String
    
    init(id: String, n: String) {
        ID = id
        name = n
    }
    
    static func ==(lhs: ListItem, rhs: ListItem) -> Bool {
        return (lhs.ID == rhs.ID)
    }
}

class ShoppingList {
    var name: String?
    var contents: [ListItem] = []
    var sharedWith: [(String, UIImage)]! = [] // possible image of food or not
    var sharedWithSET: Set<String> = []
}



// Expiration date for grocery list attemp

//       let foodAdded: String = foodName.text!
//
//        var daysToExpire = FoodData.food_data[foodAdded]!.0
//
//        let ref = Database.database().reference()
//
//        if daysToExpire <= 0 {
//            daysToExpire = 10000
//        }
//
//        let dateOfExpiration = Calendar.current.date(byAdding: .day, value: daysToExpire, to: Date())
//        let timeInterval = dateOfExpiration?.timeIntervalSinceReferenceDate
//        let doe = Int(timeInterval!)
//
//        //post name of food, and seconds from reference date (jan 1, 2001) that it will expire
//        let post = ["name" : foodAdded,
//                    "timestamp" : doe] as [String : Any]
//
//        ref.child("AllFoodLists/\(currentUser.shared.allFoodListID!)").childByAutoId().setValue(post)
//
//        if daysToExpire < 1000 {
//            getNotificationForDay(on: dateOfExpiration!, foodName: foodAdded)
//        }







