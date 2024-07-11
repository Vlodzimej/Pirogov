//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    let saleCollectionview = SaleCollectionView()
    
    let menuCollectionView = MenuCollectionView()
    
    let menuTableVC = MenuTableViewController()
    
    var timer = Timer()
    var currentIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        menuCollectionView.menuDelegate = self
        
        setConstraint()
        
        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func scrollToNext() {
        if currentIndex < saleCollectionview.imageArray.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            saleCollectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            saleCollectionview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}
    



//    MARK: - Update Table MenuTableViewController
extension MainViewController: MenuDelegate {
    
    func didUpdateTableViewData(by selectedIndex: Int) {
        menuTableVC.updateTable(by: selectedIndex)
    }
}



//    MARK: - Settings Constraints

extension MainViewController {
    
    private func setConstraint() {

        view.addSubview(saleCollectionview)
        NSLayoutConstraint.activate([
            saleCollectionview.heightAnchor.constraint(equalToConstant: 150),
            saleCollectionview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            saleCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            saleCollectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(menuCollectionView)
        NSLayoutConstraint.activate([
            menuCollectionView.heightAnchor.constraint(equalToConstant: 35),
            menuCollectionView.topAnchor.constraint(equalTo: saleCollectionview.bottomAnchor, constant: 10),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        
        view.addSubview(menuTableVC.view)
        NSLayoutConstraint.activate([
            menuTableVC.view.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: 15),
            menuTableVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}





