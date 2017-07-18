//
//  UIDevice+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import UIKit

enum ScreenType: String {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case unknown
}

extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    var screenType: ScreenType {
        guard iPhone else {
            return .unknown
        }
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 2208:
            return .iPhone6Plus
        default:
            return .unknown
        }
    }
}

