//
//  UIView+AutoLayout.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

import UIKit

// fitInSuperview
public extension UIView {
    func fitInSuperview() {
       guard let superview = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
       topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
       bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
       leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
       rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
    
    func fitInSuperviewMargins() {
       guard let superview = self.superview else { return }
       self.translatesAutoresizingMaskIntoConstraints = false
       topAnchor.constraint(equalTo: superview.topAnchor, constant:
       superview.layoutMargins.top).isActive = true
       bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant:
       -superview.layoutMargins.bottom).isActive = true
       leftAnchor.constraint(equalTo: superview.leftAnchor, constant:
       superview.layoutMargins.left).isActive = true
       rightAnchor.constraint(equalTo: superview.rightAnchor, constant:
       -superview.layoutMargins.right).isActive = true
    }
}

public extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

// MARK: - Anchors

public extension UIView {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    }
    return self.topAnchor
  }

  var safeLeadingAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.leadingAnchor
    }
    return self.leadingAnchor
  }

  var safeTrailingAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.trailingAnchor
    }
    return self.trailingAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    }
    return self.bottomAnchor
  }
}

public extension UIView {
    
    typealias LayoutAxisAnchors = (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?)
    typealias Paddings = (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    
    func anchor (layoutAxisAnchors: LayoutAxisAnchors?, paddings: Paddings, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = layoutAxisAnchors?.top {
            self.topAnchor.constraint(equalTo: top, constant: paddings.top+topInset).isActive = true
        }
        if let left = layoutAxisAnchors?.left {
            self.leftAnchor.constraint(equalTo: left, constant: paddings.left).isActive = true
        }
        if let right = layoutAxisAnchors?.right {
            rightAnchor.constraint(equalTo: right, constant: -paddings.right).isActive = true
        }
        if let bottom = layoutAxisAnchors?.bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddings.bottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}

/// Pin edges of View to its SuperView
public extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
