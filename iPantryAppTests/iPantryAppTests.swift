//
//  iPantryAppTests.swift
//  iPantryAppTests
//
//  Created by Conner Cook on 4/27/21.
//

import XCTest
@testable import iPantryApp

class IventoryViewController: XCTestCase {
    
    var Inventory: InventoryViewController! // Test cases apply only to InventoryViewController class only.

    override func setUpWithError() throws {
    
        // Instance of InventoryViewController for our tests.
        Inventory = InventoryViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Inventory = nil
    }

    func test_item_is_nil() throws {
    
        // Throws error is a Item is nil by the user. Item can't be blank.
        
        // Use XCTAssertThrowsError(try Inventory.didGetNotficiation(), "Error, item name can not be blank.")
        
        }
    }
    func test_inventorysize() throws {
    
    // Use XCTAssertTrue
    // Will check if the inventory size is 1
}

    func test_swipeDeletion() throws {
    
    // add XCT case here for a user trying to delete an empty row.
    //XCTAssertThrowsError(try Inventory.tableView(), "Error, you can not delete an empty row.")
        
    // Use XCTAssertTrue case that asserts true if item has been deleted successfully.
}

