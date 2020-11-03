//
//  ReusableCell.swift
//  GenericDataSource
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
