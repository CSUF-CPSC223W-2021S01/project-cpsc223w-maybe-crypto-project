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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Allows continous increment or decrement when pressed down
        stepper.autorepeat = true
    }
    
    //changes the quantity label to match the Uistepper
    @IBAction func stepperValChange(_ sender: UIStepper) {
        quantityLabel.text = Int(sender.value).description
    }
   
    
    @IBAction func pressedBtn(_ sender: Any) {
        //Sends the user item name to the inventory view controller.
        NotificationCenter.default.post(name: Notification.Name("text"), object: itemTextField.text)
        
        //Changes text back to empty after pressing send
        itemTextField.text = ""
        quantityLabel.text = String(0)
    }

}
