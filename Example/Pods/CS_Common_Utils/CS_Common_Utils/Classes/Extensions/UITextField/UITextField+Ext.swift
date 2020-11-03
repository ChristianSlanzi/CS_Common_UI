//
//  UITextField+Ext.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 29.10.20.
//

import UIKit

public extension UITextField {
    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        let frameHeight = self.frame.size.height
        let frameWidth = self.frame.size.width
        border.frame = CGRect(x: 0, y: frameHeight - width, width: frameWidth, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

public extension UITextField {
  func setBottomBorder() {
    borderStyle = .none
    layer.backgroundColor = UIColor.white.cgColor
    
    layer.masksToBounds = false
    
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 0.0
  }
}
