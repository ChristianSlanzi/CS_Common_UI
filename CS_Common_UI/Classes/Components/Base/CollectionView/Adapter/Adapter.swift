//
//  CustomScrollViewController.swift
//  ShoppingApp
//
//  Created by Christian Slanzi on 10.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

/// A generic adapter to act as convenient DataSource and Delegate for UICollectionView
public final class Adapter<T, Cell: UICollectionViewCell>: NSObject,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  public var items: [T] = []
  public var configure: ((T, Cell) -> Void)?
  public var select: ((T) -> Void)?
  public var cellWidth: CGFloat = 60
  public var cellHeight: CGFloat = 60
  public var numberOfSections: Int = 1

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return numberOfSections
  }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = items[indexPath.item]

    let cell: Cell = collectionView.dequeue(indexPath: indexPath)
    configure?(item, cell)
    return cell
  }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.item]
    select?(item)
  }

    public func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: cellWidth, height: cellHeight)
  }
}
