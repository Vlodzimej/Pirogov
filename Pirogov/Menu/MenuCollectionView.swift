//
//  MenuCollectionView.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit

class MenuCollectionView: UICollectionView {
    
    var cells = [MenuProducts]()
    
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
//        backgroundColor = .systemGreen
        delegate = self
        dataSource = self
        register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.id)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cell: [MenuProducts]) {
        self.cells = cell
    }
    
    
    
}

    // MARK:  - UICollectionViewDelegate

extension MenuCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
        cell.nameProduct.textColor = .white
        cell.backgroundColor = #colorLiteral(red: 0.06266801804, green: 0.2313786149, blue: 0.3019550741, alpha: 0.8709160003)
        cell.layer.masksToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        let cell  = collectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
        cell.nameProduct.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
    }
}

    // MARK: - UICollectionViewDataSource

extension MenuCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.id, for: indexPath) as? MenuCollectionViewCell {
            cell.nameProduct.text = self.cells[indexPath.row].name
            cell.layer.cornerRadius = 15
            
            return cell
        }
        return UICollectionViewCell()
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Create dinamic width items
        let label = UILabel(frame: CGRect.zero)
        label.text = self.cells[indexPath.row].name
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 20, height: 32)
    }
}
