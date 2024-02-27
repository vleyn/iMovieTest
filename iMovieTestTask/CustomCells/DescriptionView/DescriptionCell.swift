//
//  DescriptionCell.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 27.02.24.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let key = "DescriptionCell"
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    var configure: String? {
        didSet {
            descriptionLabel.text = configure ?? ""
            setupConstraints()
        }
    }
    
    private func setupConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
}
