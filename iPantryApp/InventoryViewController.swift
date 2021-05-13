//
//  InventoryViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//

import UIKit

class InventoryViewController: UIViewController {
    
    //temporary array that holds the items to be displayed
    var inventory = [
            "apple",
            "berries",
            "carrots",
        ]
    
    @IBOutlet var inventoryView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //swipe left gesture to camera page
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        
        //initiates the delegate and datasource
        inventoryView.delegate = self
        inventoryView.dataSource = self
    }
    
    // swipe left gesture to remove inventory items from table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            inventory.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension InventoryViewController: UITableViewDataSource {
    // Tells the controller how many rows are needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    // Displays the items to each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        item.textLabel?.text = inventory[indexPath.row]
        return item
    }
}

// Save Temp array data function.
func saveInventory() {
    _ = saveInventory
    
    _ = saveInventory
    
    _ = saveInventory
    
    let items = ["apple", "berries", "carrots"]
    
    // Gives access to Documents Directory, enables read and write files in that directory
    // Save a collection to a file and loaded the data back from file back into our program
    let documentsDirectory =
      FileManager.default.urls(for: .documentDirectory,
      in: .userDomainMask).first!
    let archiveURL =
      documentsDirectory.appendingPathComponent("Inventory_test")
        .appendingPathExtension("plist")
    
    let propertyListEncoder = PropertyListEncoder()
    let encodedInventory = try? propertyListEncoder.encode(items)
    try? encodedInventory?.write(to: archiveURL,
      options: .noFileProtection)
    
    let propertyListDecoder = PropertyListDecoder()
    if let retrievedInventoryData = try? Data(contentsOf: archiveURL),
        let decodedInventory = try?
          propertyListDecoder.decode(Array<String>.self, from:
          retrievedInventoryData) {
        print(decodedInventory)
    }
}
