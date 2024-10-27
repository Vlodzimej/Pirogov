//
//  DetailProductViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.05.2024.
//

import UIKit
import FirebaseFirestore

class DetailProductViewController: UIViewController {
    
    //  MARK: - Properties
    
    var nameTitleButton: String = ""
    
    var countImage: [UIImage?] = []
    
    var product: Product?

    // MARK: - UIProperties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .systemBlue
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.7004614472, green: 0.7929691672, blue: 0.8534081578, alpha: 1)
        pageControl.hidesForSinglePage = true
        pageControl.backgroundStyle = .prominent
        pageControl.allowsContinuousInteraction = false
        return pageControl
    }()
    
    private lazy var nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .light)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var ingredientsProductLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var energyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3469551802, green: 0.5091798306, blue: 0.6099575162, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var massProductLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3469551802, green: 0.5091798306, blue: 0.6099575162, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var addInCartButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        button.addTarget(nil, action: #selector(addToCart), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeScreenButton: UIButton = {
        let button = UIButton(type: .close)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = .infinity
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.7547900081, green: 0.7547900081, blue: 0.7547900081, alpha: 1)
        button.addTarget(nil, action: #selector(closeScreen), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createImage()
        setConstraints()
        
        pageControl.numberOfPages = countImage.count
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * countImage.count, height: 263)
        

        energyLabel.text = "Энергетическая ценность: 234 Ккал на 100 гр."
        
    }
    

    
    
    //  MARK: - Corusel Images
    
    private func createImage() {
        for image in 0..<countImage.count {
            let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleToFill
                imageView.image = countImage[image % countImage.count]
                return imageView
            }()
            
            stackView.addArrangedSubview(imageView)
        }
    }
    
    
    //  MARK: - Configure
    
    func configure(model product: Product) {
        
        self.product = product

        countImage = product.image.images
        nameProductLabel.text = product.name
        ingredientsProductLabel.text = "Состав: \(product.ingredients)"
        nameTitleButton = "В корзину \(product.price)" + " ₽"
        
        addInCartButton.setTitle(nameTitleButton, for: .normal)

    }
    
    
    //  MARK: - Method Add To Cart
    @objc func addToCart() {

        guard let product = product else { return }
        
        Cart.shared.addItem(product)
        
        let alert = UIAlertController(title: nil, message: "Товар добавлен в корзину", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true)
        
    }
    
    //  MARK: - Method Close Screen
    @objc func closeScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}



    //  MARK: - UIScrollViewDelegate

extension DetailProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}



    //  MARK: - Settings Constraints

extension DetailProductViewController {
    
    func setConstraints() {
        
        view.addSubview(closeScreenButton)
        closeScreenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeScreenButton.widthAnchor.constraint(equalToConstant: 25),
            closeScreenButton.heightAnchor.constraint(equalToConstant: 25),
            closeScreenButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeScreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 263),
            scrollView.topAnchor.constraint(equalTo: closeScreenButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

                
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        }
        
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(nameProductLabel)
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProductLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            nameProductLabel.heightAnchor.constraint(equalToConstant: 50),
            nameProductLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameProductLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40)
        ])
        
        
        view.addSubview(ingredientsProductLabel)
        ingredientsProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsProductLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            ingredientsProductLabel.heightAnchor.constraint(equalToConstant: 130),
            ingredientsProductLabel.topAnchor.constraint(equalTo: nameProductLabel.bottomAnchor, constant: 40),
            ingredientsProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(energyLabel)
        energyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            energyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            energyLabel.heightAnchor.constraint(equalToConstant: 30),
            energyLabel.topAnchor.constraint(equalTo: ingredientsProductLabel.bottomAnchor, constant: 15),
            energyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(massProductLabel)
        massProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            massProductLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            massProductLabel.heightAnchor.constraint(equalToConstant: 30),
            massProductLabel.topAnchor.constraint(equalTo: ingredientsProductLabel.bottomAnchor, constant: 15),
            massProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(addInCartButton)
        addInCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addInCartButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            addInCartButton.heightAnchor.constraint(equalToConstant: 40),
            addInCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addInCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}
