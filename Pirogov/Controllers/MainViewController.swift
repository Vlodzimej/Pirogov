//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //  MARK: - Properties
    
    var saleCollectionView = SaleCollectionView()
    var menuCollectionView = MenuCollectionView()
    var productsTableView = ProductsTableView()
    
    var menu = GroupProducts.setup()
    
    var isScrollingTableView = false
    
    var menuCollectionViewTopConstraint: NSLayoutConstraint!
    var saleCollectionViewTopConstraint: NSLayoutConstraint!
    
    var onScroll: ((Int) -> Void)?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        productsTableView.tableView.delegate = self
        productsTableView.tableView.dataSource = self
        
        menuCollectionView.didSelectItem = { [weak self] index in
            guard let self = self else { return }
            self.isScrollingTableView = false
            self.productsTableView.tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
        }
        
        self.onScroll = { [weak self] section in
            guard let self = self, !self.isScrollingTableView else { return }
            self.menuCollectionView.menuCollectionView.selectItem(at: IndexPath(item: section, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }


        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        
        setupSaleCollectionView()
        setupCollectionView()
        setupCustomTableView()
        
    }
    
    
    
    //  MARK: - ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print("offset = \(yOffset)")
        if yOffset < 180 {
            menuCollectionViewTopConstraint.constant = 190 - yOffset
            print("Доходит до = \(menuCollectionViewTopConstraint.constant)")
        } else {
            menuCollectionViewTopConstraint.constant = 10
        }
    }
}



    //  MARK: - Settings Constraints

extension MainViewController {

    private func setupSaleCollectionView() {
        view.addSubview(saleCollectionView)
        saleCollectionView.translatesAutoresizingMaskIntoConstraints = false

        saleCollectionViewTopConstraint = saleCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)

        NSLayoutConstraint.activate([
            saleCollectionViewTopConstraint, // !
            saleCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            saleCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            saleCollectionView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(menuCollectionView)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false

        menuCollectionViewTopConstraint = menuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 190)
        
        NSLayoutConstraint.activate([
            menuCollectionViewTopConstraint,
            menuCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuCollectionView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    private func setupCustomTableView() {
        view.addSubview(productsTableView)
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}





