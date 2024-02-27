//
//  FilmsCollectionViewCell.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import UIKit

class FilmsCollectionViewCell: UICollectionViewCell {
    
    static let key = "FilmsCollectionViewCell"
    
    lazy var filmPoster: UIImageView = {
        let poster = UIImageView()
        poster.layer.cornerRadius = 20
        poster.clipsToBounds = true
        contentView.addSubview(poster)
        return poster
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(label)
        return label
    }()
    
    var configure: Docs? {
        didSet {
            filmName.text = "\(configure?.name ?? "")"
            if let url = URL(string: configure?.poster?.previewUrl ?? "") {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.filmPoster.image = image
                        }
                    }
                }
                task.resume()
            }
            setupConstraints()
        }
    }
    
    func setupConstraints() {
        filmPoster.translatesAutoresizingMaskIntoConstraints = false
        filmPoster.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filmPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        filmPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filmPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        filmName.translatesAutoresizingMaskIntoConstraints = false
        filmName.leadingAnchor.constraint(equalTo: filmPoster.leadingAnchor, constant: 12).isActive = true
        filmName.topAnchor.constraint(equalTo: filmPoster.bottomAnchor, constant: 8).isActive = true
        filmName.trailingAnchor.constraint(equalTo: filmPoster.trailingAnchor).isActive = true
    }
}
