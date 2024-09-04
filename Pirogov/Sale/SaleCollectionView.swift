//
//  SaleCollectionView.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.06.2024.
//

import Foundation
import UIKit


class SaleCollectionView: UIView {
    
    //  MARK: - Properties
    
    private var timer: Timer?
    
    private lazy var currentIndex: IndexPath = IndexPath(item: 1, section: 0)

    let imagesArray = Sale.imagesArray
    
    var newImagesArray: [UIImage?] = []
    
    
    lazy var saleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.id)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
        startAutoScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCollectionView() {
        
        saleCollectionView.delegate = self
        saleCollectionView.dataSource = self
        
        addSubview(saleCollectionView)
        
        saleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saleCollectionView.heightAnchor.constraint(equalToConstant: 150),
            saleCollectionView.topAnchor.constraint(equalTo: topAnchor),
            saleCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            saleCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            saleCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Массив с дублируемыми элементами
        newImagesArray = [imagesArray.last!] + imagesArray + [imagesArray.first!]
        
        // Устанавка начального контент
        saleCollectionView.scrollToItem(at: currentIndex, at: .centeredHorizontally, animated: false)
        

    }

    //  MARK: - Start Scrolling CollectionView

    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }
    
//    НЕ СРАБАТЫВАЕТ
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
        print("OFF")
    }
    
    
    @objc func scrollToNext() {

        let nextItem = (currentIndex.item + 1) % saleCollectionView.numberOfItems(inSection: currentIndex.section)
                currentIndex = IndexPath(item: nextItem, section: currentIndex.section)
                
        saleCollectionView.scrollToItem(at: currentIndex, at: .centeredHorizontally, animated: true)
    }
    
    private func resetScrollPositionIfNeeded() {
        if currentIndex.item == newImagesArray.count - 1 {
            // Если на последнем элементе, перемещаемся на первый элемент (оригинальный массив)
            currentIndex = IndexPath(item: 1, section: 0)
            saleCollectionView.scrollToItem(at: currentIndex, at: .centeredHorizontally, animated: false)
        } else if currentIndex.item == 0 {
            // Если на первом элементе, перемещаемся на последний элемент (оригинальный массив)
            currentIndex = IndexPath(item: newImagesArray.count - 2, section: 0)
            saleCollectionView.scrollToItem(at: currentIndex, at: .centeredHorizontally, animated: false)
        }
    }

}

    //  MARK: - UICollectionView Delegate

extension SaleCollectionView: UICollectionViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        resetScrollPositionIfNeeded()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetScrollPositionIfNeeded()
    }
}

    //  MARK: - UICollectionViewDataSource

extension SaleCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.id, for: indexPath) as? SaleCollectionViewCell  else { return UICollectionViewCell() }
        
        cell.imageView.image = newImagesArray[indexPath.item]
        return cell
    }
}


    //  MARK: - UICollectionViewDelegateFlowLayout

extension SaleCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 150)
    }
}
