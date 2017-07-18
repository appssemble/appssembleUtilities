//
//  NSLayoutConstraint+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    @IBInspectable var iphone4Constraint: CGFloat {
        get {
            return self.constant
        }
        
        set {
            if UIDevice().screenType == .iPhone4 {
                self.constant = newValue
            }
        }
    }
    
    @IBInspectable var iphone5Constraint: CGFloat {
        get {
            return self.constant
        }
        
        set {
            if UIDevice().screenType == .iPhone5 {
                self.constant = newValue
            }
        }
    }
}

