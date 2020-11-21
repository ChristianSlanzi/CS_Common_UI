//
//  UITableView+Empty.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

import UIKit

public extension UITableView {
    func setEmptyView(title: String, message: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let containedEmptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 200/*self.bounds.size.height*/))
        containedEmptyView.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            return titleLabel
        }()
        
        let messageLabel: UILabel = {
            let messageLabel = UILabel()
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.textColor = UIColor.black
            messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
            return messageLabel
        }()
        
        // setup views
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        emptyView.addSubview(containedEmptyView)
        
        containedEmptyView.addSubview(titleLabel)
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        containedEmptyView.addSubview(messageLabel)
        
        // setup constraints
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10),
            //titleLabel.centerYAnchor.constraint(equalTo: containedEmptyView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containedEmptyView.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: containedEmptyView.rightAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
        messageLabel.centerYAnchor.constraint(equalTo: containedEmptyView.centerYAnchor, constant: 10),
        messageLabel.leftAnchor.constraint(equalTo: containedEmptyView.leftAnchor, constant: 20),
        messageLabel.rightAnchor.constraint(equalTo: containedEmptyView.rightAnchor, constant: -20)
        ])
        
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
