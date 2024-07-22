//
//  ViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    var saleCollectionview: SaleCollectionView!
    
    var menuCollectionView: MenuCollectionView!
    
    var menuTableVC = MenuTableViewController()
    
    
    var timer = Timer()
    var currentIndex = 0
    
    
    private lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        return scrollView
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        let saleCVConstantY = CGFloat(10)
        saleCollectionview = SaleCollectionView(frame: CGRect(x: 0, y: saleCVConstantY, width: view.bounds.width, height: 150))
        
        
        let menuCVConstantY = CGFloat(170)
        menuCollectionView = MenuCollectionView(frame: CGRect(x: 10, y: menuCVConstantY, width: view.bounds.width, height: 40))
        
        scrollView.delegate = self
        
        menuCollectionView.menuDelegate = self
        menuCollectionView.set(cell: MenuProducts.fetchMenu())
        
        
        setConstraint()

        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        }
        
    }
//    MARK: - Scrolling SaleCollectionView
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
    
//    MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pr = "Начинается прокрутка"
        print(pr)
        print(scrollView.contentOffset.y)
        
        let currentContentOffsetY = scrollView.contentOffset.y
        let initialY = CGFloat(170)     // Остановка menuCollectionView от верхней границы экрана
        let newOriginY = max(97, initialY - currentContentOffsetY)
        menuCollectionView.frame.origin.y = newOriginY
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
        
        view.addSubview(scrollView)
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        



        scrollView.addSubview(saleCollectionview)
//        saleCollectionview.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            saleCollectionview.heightAnchor.constraint(equalToConstant: 150),
//            saleCollectionview.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
//            saleCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            saleCollectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
        
        view.addSubview(menuCollectionView)
//        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            menuCollectionView.heightAnchor.constraint(equalToConstant: 40),
//            menuCollectionView.topAnchor.constraint(equalTo: saleCollectionview.bottomAnchor, constant: 10),
//            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//        ])
        
        
        scrollView.addSubview(menuTableVC.view)
        NSLayoutConstraint.activate([
            menuTableVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 220),
            menuTableVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}





