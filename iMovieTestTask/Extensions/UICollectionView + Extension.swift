//
//  UICollectionView + Extension.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import UIKit

//MARK: - Extension for register and reuse CV cell with generics -

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type)  {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
