//
//  ViewController.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 26.02.24.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK: - Property -
    
    private var apiManager: ApiManager = KpApiManager()
    var films: FilmData?
    var docs: [Docs] = []
    
    var currentPage = 1
    var totalPages = 2
        
    lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.register(FilmsCollectionViewCell.self)
        view.addSubview(collectionView)
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular films"
        fetchData(page: currentPage)
        setupConstraints()
    }
    
    //MARK: - Get data from API -
        
    func fetchData(page: Int) {
        currentPage += 1
        apiManager.fetchData(page: page) { response in
                switch response {
                case .success(let films):
                    self.films? = films
                    self.docs += films.docs ?? []
                    self.totalPages = films.pages ?? 0
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    //MARK: - Make constraints for CV -
        
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: - Extension UICollectionView -
    
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        docs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilmsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure = docs[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 16, height: collectionView.frame.width / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FilmsCollectionViewCell {
            let dataToPass = cell.configure
            let descriptionVC = DescriptionViewController()
            descriptionVC.data = dataToPass
            self.navigationController?.pushViewController(descriptionVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == docs.count - 2, currentPage < totalPages {
            fetchData(page: currentPage)
        }
    }
}
