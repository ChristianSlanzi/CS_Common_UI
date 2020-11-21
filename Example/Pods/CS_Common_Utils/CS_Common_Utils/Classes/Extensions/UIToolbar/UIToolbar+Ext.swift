//
//  UIToolbar+Ext.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

import UIKit

public extension UIToolbar {

    func toolbarPicker(selector: Selector) -> UIToolbar {

        let toolBar = UIToolbar()

        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done".localized, style: UIBarButtonItem.Style.plain, target: self, action: selector)
        doneButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }
}
