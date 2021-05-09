//
//  InventoryViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//

import UIKit

class InventoryViewController: UIViewController {
    
    //temporary array that holds the items to be displayed
    let inventory = [
            "apple",
            "berries",
            "carrots"
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
    //basically tells the controller how many rows are needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    //displays the items to each row 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        item.textLabel?.text = inventory[indexPath.row]
        return item
    }
}
