//
//  Date+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import Foundation

extension Date {
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    static func dateFromString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: string)!
        
        return date
    }
    
    func longDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm a"
        
        return dateFormatter.string(from: self)
    }
}
