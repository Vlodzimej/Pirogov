//
//  MenuTableViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 17.05.2024.
//

import UIKit

class ProductsTableView: UIView {
    
    
    // MARK: - Public properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.id)
        return tableView
    }()
    
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods

    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}







