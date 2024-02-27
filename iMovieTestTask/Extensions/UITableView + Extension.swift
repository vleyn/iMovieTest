//
//  UITableView + Extension.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import UIKit

//MARK: - Extension for register and reuse TV cell with generics -

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type)  {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T  {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
