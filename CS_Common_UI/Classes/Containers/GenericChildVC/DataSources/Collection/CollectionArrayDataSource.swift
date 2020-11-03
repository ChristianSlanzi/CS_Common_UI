//
//  CollectionArrayDataSource.swift
//  GenericDataSource
//
//  Created by Christian Slanzi on 13.01.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

open class CollectionArrayDataSource<T, Cell: UICollectionViewCell>: CollectionDataSource<CollectionArrayDataProvider<T>, Cell>
    where Cell: ConfigurableCell, Cell.T == T {
    // MARK: - Lifecycle
    public convenience init(collectionView: UICollectionView, array: [T]) {
        self.init(collectionView: collectionView, array: [array])
    }

    public init(collectionView: UICollectionView, array: [[T]]) {
        let provider = CollectionArrayDataProvider(array: array)
        super.init(collectionView: collectionView, provider: provider)
    }

    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }

    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
}
