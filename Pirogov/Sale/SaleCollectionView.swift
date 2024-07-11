//
//  SaleCollectionView.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.06.2024.
//

import Foundation
import UIKit


class SaleCollectionView: UICollectionView {
    
    var imageArray = [UIImage(named: "sale_bd"),
                      UIImage(named: "sale_combo_1"),
                      UIImage(named: "sale_combo_2"),
                      UIImage(named: "sale_combo_3"),
                      UIImage(named: "sale_combo_4")]
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.id)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//    MARK: - UICollectionView Delegate

extension SaleCollectionView: UICollectionViewDelegate {
    
}

//    MARK: - UICollectionViewDataSource

extension SaleCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.id, for: indexPath) as? SaleCollectionViewCell {
            cell.imageView.image = imageArray[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }  
}


//    MARK: - UICollectionViewDelegateFlowLayout

extension SaleCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 150)
    }
}
