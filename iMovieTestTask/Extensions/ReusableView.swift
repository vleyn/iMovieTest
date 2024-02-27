//
//  ReusableView.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: ReusableView{}
extension UICollectionViewCell: ReusableView{}
