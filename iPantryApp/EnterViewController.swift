//
//  EnterViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 5/12/21.
//

import UIKit

class EnterViewController: UIViewController {

    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var enterBtn: UIButton!
    
    var inventory = Inventory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //swipe right gesture to inventory page
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        print(rightSwipe)
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
        stepper.autorepeat = true
    }
    
    @IBAction func stepperValChange(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
   
    @IBAction func pressedBtn(_ sender: Any) {
        let quantity = Int(quantityLabel.text!)
        inventory.add(itemTextField.text!, quantity: quantity!)
        itemTextField.text = ""
        quantityLabel.text = String(0)
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
