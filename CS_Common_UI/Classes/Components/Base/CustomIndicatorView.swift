//
//  CustomIndicatorView.swift
//  CS_Common_UI
//
//  Created by Christian Slanzi on 27.10.20.
//

import UIKit

public class CustomIndicatorView: CustomView {
    lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    public func showActivityIndicator() {
        activityView.startAnimating()
    }

    public func hideActivityIndicator() {
        activityView.stopAnimating()
    }
    
    public override func setupViews() {
        self.addSubview(activityView)
    }
    
    public override func setupConstraints() {
        activityView.center = self.center
    }
}
