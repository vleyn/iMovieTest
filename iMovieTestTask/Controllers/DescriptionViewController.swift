//
//  DescriptionViewController.swift
//  iMovieTestTask
//
//  Created by Владислав Мазуров on 27.02.24.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    //MARK: - Property -
    
    var data: Docs?
    
    lazy var descriptionTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(PosterCell.self)
        tableView.register(LogoCell.self)
        tableView.register(DescriptionCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(descriptionTableView)
        setupConstraints()
    }
    
    //MARK: - Make constraints for TV -
    
    private func setupConstraints() {
        descriptionTableView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        descriptionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK: - Extension UITableView -

extension DescriptionViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let posterCell: PosterCell = tableView.dequeueReusableCell(for: indexPath)
            posterCell.configure = data?.poster?.previewUrl
            return posterCell
        case 1:
            let logoCell: LogoCell = tableView.dequeueReusableCell(for: indexPath)
            logoCell.configure = data?.logo?.url
            return logoCell
        case 2:
            let descriptionCell: DescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            descriptionCell.configure = "\(data?.shortDescription ?? "") \(data?.description ?? "")"
            return descriptionCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 500
        case 1: return UITableView.automaticDimension
        case 2: return UITableView.automaticDimension
        default: return 0
        }
    }
}
