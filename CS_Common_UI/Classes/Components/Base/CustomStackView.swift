//
//  CustomStackView.swift
//  Mitarbeiterapp demo
//
//  Created by Christian Slanzi on 22.09.20.
//  Copyright © 2020 proofIT. All rights reserved.
//

import UIKit

open class CustomStackView: UIStackView, CustomViewProtocol {
    public init() {
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
        setupBehaviors()
        setupActions()
    }
    
    //initWithFrame to init view from code
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupBehaviors()
        setupActions()
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //custom views should override this to return true if
    //they cannot layout correctly using autoresizing.
    //from apple docs https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
    override public class var requiresConstraintBasedLayout: Bool {
      return true
    }
    
    //common func to init our view
    open func setupViews() {
        
    }
    
    //common func to init behaviors, i.e. set delegates
    open func setupBehaviors() {
    }
    
    //common func to set autolayout constraints
    open func setupConstraints() {
    }
    
    //common func to set actions with targets and selectors
    open func setupActions() {
      //addButton.addTarget(self, action: #selector(moveHeaderView), for: .touchUpInside)
    }
}
