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
    
    private var cartItem: CartItem?
    
    
    
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        //        stackView.backgroundColor = .gray
        return stackView
    }()
    
    private lazy var minCountProductButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
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
    
    private lazy var maxCountProducButtont: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 17, weight: .medium)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
//        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        stackView.addArrangedSubview(nameProductLabel)
        stackView.addArrangedSubview(priceLabel)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    // MARK: - Configuration
    
    func configureCell(with product: CartItem) {
        
        self.cartItem = product
        
        productImageView.image = cartItem?.product.image.images[0] ?? UIImage(named: "picture")
        nameProductLabel.text = cartItem?.product.name
        priceLabel.text = "\(cartItem!.product.price) ₽"
        countProductLabel.text = "\(String(describing: cartItem!.quantity))"
    }
}




    //  MARK: - Settings Constraints

extension CartTableViewCell {
    
    func setConstraints() {
        self.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 90),
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            productImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        self.addSubview(nameProductLabel)
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProductLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70),
            nameProductLabel.heightAnchor.constraint(equalToConstant: 45),
            nameProductLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15)
        ])
        
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.widthAnchor.constraint(equalToConstant: 70),
            priceLabel.heightAnchor.constraint(equalToConstant: 35),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15)
        ])
        
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
//            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
        
        
        stackView.addSubview(minCountProductButton)
        minCountProductButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minCountProductButton.widthAnchor.constraint(equalToConstant: 30),
            minCountProductButton.heightAnchor.constraint(equalToConstant: 30),
            minCountProductButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            minCountProductButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        ])
        
        stackView.addSubview(countProductLabel)
        countProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countProductLabel.widthAnchor.constraint(equalToConstant: 30),
            countProductLabel.heightAnchor.constraint(equalToConstant: 30),
            countProductLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
//            countProductLabel.leadingAnchor.constraint(equalTo: minCountProductButton.trailingAnchor, constant: 5)
            countProductLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
        
        stackView.addSubview(maxCountProducButtont)
        maxCountProducButtont.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxCountProducButtont.widthAnchor.constraint(equalToConstant: 30),
            maxCountProducButtont.heightAnchor.constraint(equalToConstant: 30),
            maxCountProducButtont.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            maxCountProducButtont.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}


