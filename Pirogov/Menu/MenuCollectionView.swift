//
//  MenuCollectionView.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import UIKit


class MenuCollectionView: UIView {

    //  MARK: - Properties

    var cells = [MenuProducts]()
    
    var didSelectItem: ((Int) -> Void)?

    private var selectedIndexGroup: Int = 0
    
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.id)
        return collectionView
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        setupCollectioView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func set(cell: [MenuProducts]) {
        self.cells = cell
    }
    
    //  MARK: - Method SetupCollectionView
    
    private func setupCollectioView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        addSubview(menuCollectionView)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuCollectionView.heightAnchor.constraint(equalToConstant: 50),
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}




    //  MARK:  - UICollectionViewDelegate

extension MenuCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.selectedIndexGroup = indexPath.item
        collectionView.reloadData()
        
        didSelectItem?(indexPath.item)
        
        print(selectedIndexGroup)
    }
}



    //  MARK: - UICollectionViewDataSource

extension MenuCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.id, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
            cell.nameProductLabel.text = self.cells[indexPath.row].name
            cell.layer.cornerRadius = 15

            if indexPath.item == selectedIndexGroup {
                cell.nameProductLabel.textColor = .white
                cell.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 0.8709160003)
            } else {
                cell.nameProductLabel.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
                cell.backgroundColor = .white
            }
            return cell
        }
    }


    //  MARK: - UICollectionViewDelegateFlowLayout

extension MenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Create dinamic width items
        let label = UILabel(frame: CGRect.zero)
        label.text = self.cells[indexPath.row].name
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 20, height: 32)
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
}
