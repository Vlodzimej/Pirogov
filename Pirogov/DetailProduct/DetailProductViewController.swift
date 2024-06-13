//
//  DetailProductViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.05.2024.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    var nameTitleButton: String = ""
    
    var countImage: [UIImage?] = []
    
    var productImages = GroupProducts.setup()
    
    
    
    // MARK: - UIProrerties
    
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
    
    let nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .light)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
        //        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    
    let ingredientsProductLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 6
        //        label.backgroundColor = .systemBlue
        return label
    }()
    
    let energyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3469551802, green: 0.5091798306, blue: 0.6099575162, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let massProductLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3469551802, green: 0.5091798306, blue: 0.6099575162, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
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
        
//        contentView.frame.size = CGSize(width: Int(UIScreen.main.bounds.width) * countImage.count, height: Int(UIScreen.main.bounds.height))
        

        energyLabel.text = "Энергетическая ценность: 234 Ккал на 100 гр."
        addButton.setTitle(nameTitleButton, for: .normal)
        
    }
    
    
    
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
    
    
    // MARK: - Configure
    
    func configure(model product: Product) {
        countImage = product.image.images
        nameProductLabel.text = product.name
        ingredientsProductLabel.text = "Состав: \(product.ingredients ?? "")"
        nameTitleButton = "В корзину  " + String(product.price ?? 0) + " ₽"
    }
    
    
    
}
// MARK: - UIScrollViewDelegate

extension DetailProductViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}



// MARK: - Settings Constraints

extension DetailProductViewController {
    
    func setConstraints() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalToConstant: 263),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            nameProductLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameProductLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40)
        ])
        
        
        view.addSubview(ingredientsProductLabel)
        ingredientsProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ingredientsProductLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            ingredientsProductLabel.heightAnchor.constraint(equalToConstant: 120),
            ingredientsProductLabel.topAnchor.constraint(equalTo: nameProductLabel.bottomAnchor, constant: 40),
            ingredientsProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            //            compositionProduct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
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
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}
