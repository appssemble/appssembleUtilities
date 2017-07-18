//
//  String+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import Foundation

public extension String {
    public var isNumeric: Bool {
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
    
    public var isEmptyOrWhitespaces: Bool {
        if isEmpty {
            return true
        }
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
