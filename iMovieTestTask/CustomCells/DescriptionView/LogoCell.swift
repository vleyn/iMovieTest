//
//  LogoCell.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 27.02.24.
//

import UIKit

class LogoCell: UITableViewCell {
    
    static let key = "LogoCell"
    
    lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleToFill
        contentView.addSubview(logo)
        return logo
    }()
    
    var configure: String? {
        didSet {
            if let url = URL(string: configure ?? "") {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.logo.image = image
                        }
                    }
                }
                task.resume()
            }
            setupConstraints()
        }
    }
    
    private func setupConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        logo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
