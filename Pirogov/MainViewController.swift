//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    let menuCollectionView = MenuCollectionView()
    
    let menuTableVC = MenuTableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        menuCollectionView.menuDelegate = self
        
        setConstraint()
        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        


    }
}
    // MARK: - Update Table MenuTableViewController
extension MainViewController: MenuDelegate {
    
    func didUpdateTableViewData(by selectedIndex: Int) {
        menuTableVC.updateTable(by: selectedIndex)
    }
}



    // MARK: - Settings Constraints

extension MainViewController {
    
    func setConstraint() {
        view.addSubview(menuCollectionView)
        NSLayoutConstraint.activate([
            menuCollectionView.heightAnchor.constraint(equalToConstant: 35),
            menuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])

        view.addSubview(menuTableVC.view)
        NSLayoutConstraint.activate([
            menuTableVC.view.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: 20),
            menuTableVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}





