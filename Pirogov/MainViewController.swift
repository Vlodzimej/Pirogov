//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit


class MainViewController: UIViewController {
    

    let imageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let menuCollectionView = MenuCollectionView()
    
    let menuTableVC = MenuTableViewController()
    
    

    
    // !!!
//    var indexPatch = IndexPath(item: 1, section: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        self.navigationItem.titleView = imageView
        
        setConstraint()
        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        
//                menuCollectionView.selectItem(at: indexPatch, animated: false, scrollPosition: .centeredHorizontally)
        
        
    }
}


    // MARK: - Settings Constraints

extension MainViewController {
    
    func setConstraint() {
        view.addSubview(menuCollectionView)
        NSLayoutConstraint.activate([
            menuCollectionView.heightAnchor.constraint(equalToConstant: 35),
            menuCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
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





