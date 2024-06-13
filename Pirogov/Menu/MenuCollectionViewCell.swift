//
//  MenuCollectionViewCell.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import Foundation

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    
    static let id = "MenuCollectionViewCell"
    
    
    let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.sizeToFit()
        return label
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Settings Constraints
    
    func setConstraints() {
        self.addSubview(nameProductLabel)
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProductLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameProductLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
