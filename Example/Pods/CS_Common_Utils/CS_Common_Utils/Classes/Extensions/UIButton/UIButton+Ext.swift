//
//  UIButton+Ext.swift
//  Utils
//
//  Created by Christian Slanzi on 27.09.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public extension UIButton {
    var normalBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .normal)}
        set { self.setBackgroundImage(newValue, for: .normal)}
    }
    var normalTitleColor: UIColor? {
        get { return self.titleColor(for: .normal)}
        set { self.setTitleColor(newValue, for: .normal)}
    }
}

public extension UIButton {

    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
}
