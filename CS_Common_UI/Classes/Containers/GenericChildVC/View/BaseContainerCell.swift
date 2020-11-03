//
//  BaseContainerCell.swift
//  FitGoal
//
//  Created by Christian Slanzi on 07.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit
import CS_Common_Utils

struct BaseContainerCellModel {
    var backgroundColor: UIColor = .darkGray
}

class BaseContainerCell<T, Cell: UICollectionViewCell, U, UCell: UITableViewCell>: UITableViewCell
where Cell: ConfigurableCell, Cell: CoordinatedCell, Cell.T == T, UCell: ConfigurableCell, UCell.T == U {
    
    var coordinator: AnyObject?
    
    //TODO: inject datasource
    var datasource = [T]()
    
    //TODO: replace with above injected model
    var model: BaseContainerCellModel? {
        didSet {
            backgroundColor = model?.backgroundColor
        }
    }
    
    weak var containerController: ContainerController<T, Cell, U, UCell>? {
        didSet {
            setupChildViews()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //backgroundColor = .darkGray
    }
    
    fileprivate func setupChildViews() {
        guard let containerController = containerController else { return }
        let flowlayout = UICollectionViewFlowLayout()
        let contentCollection = ChildController<T, Cell>(collectionViewLayout: flowlayout)
        contentCollection.datasource = datasource
        contentCollection.coordinator = coordinator
        contentCollection.collectionView.backgroundColor = .white //overwrite the default color
        flowlayout.scrollDirection = .horizontal
        
        containerController.addChild(contentCollection)
        addSubview(contentCollection.view)
        contentCollection.didMove(toParent: containerController)
        
        contentCollection.view.anchor(top: topAnchor, paddingTop: 5, bottom: bottomAnchor, paddingBottom: 0,
                                      left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
