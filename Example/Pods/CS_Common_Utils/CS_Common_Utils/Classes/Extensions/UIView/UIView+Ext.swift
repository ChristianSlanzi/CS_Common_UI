//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 20.07.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// Add an array of subviews to a SuperView
public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}


// QUICKLY INSTANTIATE AN UIVIEW FROM A NIB / XIB FILE
public extension UIView {
    class func load(nib name: String) -> UIView? {
        return UINib(
            nibName: name,
            bundle: Bundle.main
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

public extension UIView {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}

public extension UIView {
  func circleCorner() {
        superview?.layoutIfNeeded()
        setCorner(radius: frame.height / 2)
    }
}

public extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
// MARK: - Custom Rounded Corners

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// EXAMPLE:
private let testview = UIView.load(nib: "CustomButton")


// QUICKLY CREATE A SNAPSHOT OF A UIVIEWCONTROLLER AS A UIIMAGE
public extension UIView {
    func toImageSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

