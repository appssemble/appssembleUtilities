//
//  UIView+Extension.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import UIKit

extension UIView {
    
    func clipToSuperview() {
        if let superview = superview {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        }
    }
    
    func addUnderline(height: CGFloat, color: UIColor) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - height, width: frame.size.width, height: height)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.addSubview(border)
    }
    
    func roate(amount: Double) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(amount))
        })
    }
}
