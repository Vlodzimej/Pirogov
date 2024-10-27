//
//  CartController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 23.05.2024.
//

import UIKit

class CartViewController: UIViewController {
    
    //  MARK: - Properties
    private lazy var tableView = UITableView()
    
    private var cartItems: [CartItem] {
        return Cart.shared.items
    }
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var orderTotalLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .light)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.text = "Сумма заказа:"
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        button.setTitle("Заказать", for: .normal)
//        button.addTarget(nil, action: #selector(), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false

        setConstraints()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        updateTotalPrice()
    }
    
    

    //  MARK: - Method Update Total Price
    
    private func updateTotalPrice() {
        totalPriceLabel.text = "\(Cart.shared.totalPrice()) ₽"
    }
    
    //  MARK: - Method Update Cart
    
    private func updateCart(for product: Product, with newQuantity: Int) {
        Cart.shared.updateItem(product, quantity: newQuantity)
        tableView.reloadData()
        updateTotalPrice()
    }
}



    //  MARK: - UITableView Delegate

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}


    //  MARK: - UITableView DataSeource

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.id, for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let cartItem = Cart.shared.items[indexPath.row]
        
        cell.configureCell(with: cartItem)
        
        cell.onUpdateQuantity = { [weak self] product, changeQuantity in
            let currentQuantety = cartItem.quantity
            let newQuantity = currentQuantety + changeQuantity
            self?.updateCart(for: product, with: newQuantity)
        }
        
        return cell
    }
}






    //  MARK: - Settings Constraints

extension CartViewController {
    
    func setConstraints() {

        view.addSubview(orderButton)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            orderButton.heightAnchor.constraint(equalToConstant: 40),
            orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.bottomAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: -50)
        ])
        
        stackView.addSubview(orderTotalLabel)
        orderTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderTotalLabel.widthAnchor.constraint(equalToConstant: 150),
            orderTotalLabel.heightAnchor.constraint(equalToConstant: 35),
            orderTotalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15)
        ])
        
        stackView.addSubview(totalPriceLabel)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalPriceLabel.widthAnchor.constraint(equalToConstant: 150),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 35),
            totalPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        ])

    }
}


