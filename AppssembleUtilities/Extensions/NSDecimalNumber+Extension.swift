//
//  NSDecimalNumber+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import Foundation

func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

extension NSDecimalNumber {
    var clean: String {
        let formatter = NumberFormatter()
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        
        if var str = formatter.string(from: self) {
            let itemsAfterDot = str.components(separatedBy: ".")
            if itemsAfterDot.count == 2, itemsAfterDot[1].characters.count == 1 {
                str = str + "0"
            }
            
            return str
        } else {
            fatalError("Could not convert value")
        }
    }
    
    func multiplyWithInt(_ int: Int) -> NSDecimalNumber {
        let decimal = NSDecimalNumber(value: int)
        
        return self.multiplying(by: decimal)
    }
    
    func divideWithInt(_ int: Int) -> NSDecimalNumber {
        let decimal = NSDecimalNumber(value: int)
        
        return self.dividing(by: decimal)
    }
    
    func discountedWithInt(_ int: Int) -> NSDecimalNumber {
        let discount = NSDecimalNumber(value: int)
        let hundred = NSDecimalNumber(value: 100)
        
        return self.subtracting(self.multiplying(by: discount).dividing(by: hundred))
        
    }
}
