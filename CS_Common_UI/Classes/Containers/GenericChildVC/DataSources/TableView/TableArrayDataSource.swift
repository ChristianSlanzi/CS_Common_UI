//
//  TableArrayDataSource.swift
//  GenericDataSource
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

open class TableArrayDataSource<T, Cell: UITableViewCell>: TableDataSource<TableArrayDataProvider<T>, Cell>
    where Cell: ConfigurableCell, Cell.T == T {
    // MARK: - Lifecycle
    public convenience init(tableView: UITableView, array: [T]) {
        self.init(tableView: tableView, array: [array])
    }

    public init(tableView: UITableView, array: [[T]]) {
        let provider = TableArrayDataProvider(array: array)
        super.init(tableView: tableView, provider: provider)
    }

    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }

    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
}
