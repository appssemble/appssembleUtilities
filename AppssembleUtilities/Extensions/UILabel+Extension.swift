//
//  UILabel+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import UIKit

public extension UILabel {
    @IBInspectable var iphone4FontSize: CGFloat {
        get {
            guard let font = self.font else {
                return 0
            }
            
            return font.pointSize
        }
        
        set {
            if UIDevice().screenType == .iPhone4 {
                font = self.font?.withSize(newValue)
            }
        }
    }
    
    @IBInspectable var iphone5FontSize: CGFloat {
        get {
            guard let font = self.font else {
                return 0
            }
            
            return font.pointSize
        }
        
        set {
            if UIDevice().screenType == .iPhone5 {
                font = self.font?.withSize(newValue)
            }
        }
    }
}
