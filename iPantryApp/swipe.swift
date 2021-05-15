//
//  swipe.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//
import UIKit
import Foundation

//allows swipe function to work on both inventory and camera view controllers since we extended the UIViewController
//this is no longer in use because we took out the swipe feature
extension UIViewController {
   @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "swipeRight", sender: self)
        case 2:
            performSegue(withIdentifier: "swipeLeft", sender: self)
        default:
            break
        }
    }
}
