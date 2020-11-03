//
//  ChildController.swift
//  FitGoal
//
//  Created by Christian Slanzi on 07.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import UIKit

class ChildController<T, Cell: UICollectionViewCell>: UICollectionViewController, UICollectionViewDelegateFlowLayout
where Cell: ConfigurableCell, Cell: CoordinatedCell, Cell.T == T {
    
    var datasource: [T] = []
    var coordinator: AnyObject?
    
    var flowLayout: UICollectionViewFlowLayout {
        let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        return layout!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .lightGray //default color. can be from outside replaced
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath)
        if let cell = cell as? Cell {
            cell.configure(datasource[indexPath.row], at: indexPath)
            if let coordinator = coordinator {
                cell.coordinatedBy(coordinator)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
