//
//  InventoryViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//

import UIKit

class InventoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //swipe left gesture to camera page
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
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
