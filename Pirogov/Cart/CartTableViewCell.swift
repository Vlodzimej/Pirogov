//
//  CartTableViewCell.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 07.08.2024.
//

import Foundation


import Foundation
import UIKit



class CartTableViewCell: UITableViewCell {
    
    //  MARK: - Properties
    
    static let id = "Cell"
    
    var product: Product?

    var onUpdateQuantity: ((Product, Int) -> Void)?
    
    // MARK: - UIProrerties
    
    private lazy var productImageView: UIImageView = {
        let image = UIImage(named: "image1.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 90, height: 57)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 13, weight: .medium)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
//        label.backgroundColor = .green
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
//        label.backgroundColor = .blue
        return label
    }()
    
    
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        button.addTarget(nil, action: #selector(decreaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private lazy var countProductLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "1"
        label.textAlignment = .center
//        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        button.addTarget(nil, action: #selector(increaseQuantity), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [removeButton, countProductLabel, addButton])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        //        stackView.backgroundColor = .gray
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    // MARK: - Configuration
    
    func configureCell(with cartItem: CartItem) {
        
        self.product = cartItem.product
        
        productImageView.image = product?.image.images[0] ?? UIImage(named: "picture")
        nameProductLabel.text = product?.name
        priceLabel.text = "\(product?.price ?? 0) ₽"
        countProductLabel.text = "\(String(describing: cartItem.quantity))"
    }
    
    //  MARK: - Method Decrease quantity product
    
    @objc func decreaseQuantity() {
        guard let product = product else { return }
        onUpdateQuantity?(product, -1)
        print("-")
    }
    
    
    //  MARK: - Method Increase quantity product

    @objc func increaseQuantity() {
        guard let product = product else { return }
        onUpdateQuantity?(product, 1)
        print("+")
    }
    
}




    //  MARK: - Settings Constraints

extension CartTableViewCell {
    
    func setConstraints() {
        contentView.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 90),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            productImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        contentView.addSubview(nameProductLabel)
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProductLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
            nameProductLabel.heightAnchor.constraint(equalToConstant: 45),
            nameProductLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15)
        ])
        
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.widthAnchor.constraint(equalToConstant: 70),
            priceLabel.heightAnchor.constraint(equalToConstant: 35),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15)
        ])
        
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
        
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.widthAnchor.constraint(equalToConstant: 30),
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            removeButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        ])
        
        countProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countProductLabel.widthAnchor.constraint(equalToConstant: 30),
            countProductLabel.heightAnchor.constraint(equalToConstant: 30),
            countProductLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            countProductLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}


