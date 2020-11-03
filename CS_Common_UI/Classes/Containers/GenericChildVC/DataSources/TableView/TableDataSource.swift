//
//  TableDataSource.swift
//  GenericDataSource
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

public typealias TableItemSelectionHandlerType = (IndexPath) -> Void

open class TableDataSource<Provider: TableDataProvider, Cell: UITableViewCell>: NSObject,
    UITableViewDataSource,
    UITableViewDelegate
    where Cell: ConfigurableCell, Provider.T == Cell.T {
    
    // MARK: - Delegates
    public var tableItemSelectionHandler: TableItemSelectionHandlerType?

    // MARK: - Private Properties
    let provider: Provider
    let tableView: UITableView

    // MARK: - Lifecycle
    init(tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        super.init()
        setUp()
    }

    func setUp() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier,
            for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        let item = provider.item(at: indexPath)
        if let item = item {
            cell.configure(item, at: indexPath)
        }
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }

    /*
    open func tableView(_ tableView: UITableView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UITableReusableView
    {
        return UITableReusableView(frame: CGRect.zero)
    }
 */

    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath) {
        tableItemSelectionHandler?(indexPath)
    }
}
