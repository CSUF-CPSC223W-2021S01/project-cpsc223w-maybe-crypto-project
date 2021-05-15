//
//  InventoryViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//

import UIKit

class InventoryViewController: UIViewController {
    //initilize the pantry
    var pantry: Inventory!
    @IBOutlet var inventoryView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //initilizes a getter that will recieve user input item
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: NSNotification.Name("text"), object: nil)

//        initiates the delegate and datasource
        pantry = Inventory()
        inventoryView.delegate = self
        inventoryView.dataSource = self
    }
    
    //This function uses the notification center and gets the user input item
    @objc func didGetNotification(_ notification: Notification) {
        let text = notification.object as! String?
        pantry.inventory.items.append(text!)
        pantry.save()
        inventoryView.reloadData()
    }

    //Allows ability to swipe right to delete the item from inventory
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pantry.inventory.items.remove(at: indexPath.row)
            pantry.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
        
        }
    }
    
}

//The action if the row is touched
extension InventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension InventoryViewController: UITableViewDataSource {
    // Tells the controller how many rows are needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantry.inventory.items.count
    }
    
    // Displays the items to each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        item.textLabel?.text = pantry.inventory.items[indexPath.row]
        return item
    }
}

