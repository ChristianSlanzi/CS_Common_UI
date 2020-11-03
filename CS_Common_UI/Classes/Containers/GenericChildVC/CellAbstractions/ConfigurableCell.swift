//
//  ConfigurableCell.swift
//  GenericDataSource
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T

    func configure(_ item: T, at indexPath: IndexPath)
}

public protocol CoordinatedCell {
    func coordinatedBy(_ coordinator: AnyObject)
}
