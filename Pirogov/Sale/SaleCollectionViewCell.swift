//
//  SaleCollectionViewCell.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.06.2024.
//

import Foundation
import UIKit


class SaleCollectionViewCell: UICollectionViewCell {
    
    static let id = "SaleCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "sale_bd")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//    MARK: - Settings Constraints

extension SaleCollectionViewCell {
    private func setConstraints() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])

    }
}

