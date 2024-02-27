//
//  PosterCell.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 27.02.24.
//

import UIKit

class PosterCell: UITableViewCell {
    
    static let key = "PosterCell"
    
    lazy var filmPoster: UIImageView = {
        let poster = UIImageView()
        contentView.addSubview(poster)
        return poster
    }()
    
    var configure: String? {
        didSet {
            if let url = URL(string: configure ?? "") {
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
    
    private func setupConstraints() {
        filmPoster.translatesAutoresizingMaskIntoConstraints = false
        filmPoster.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        filmPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        filmPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        filmPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
