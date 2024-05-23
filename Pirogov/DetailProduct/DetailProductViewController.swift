//
//  DetailProductViewController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 20.05.2024.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    let menuTableViewCell = MenuTableViewCell()
    
    let images: [UIImage] = [UIImage.image1, UIImage.image2, UIImage.image3, UIImage.image4, UIImage.image5]
    
    var nameTitleButton: String = ""
    
    // MARK: - UIProrerties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.7004614472, green: 0.7929691672, blue: 0.8534081578, alpha: 1)
        pageControl.hidesForSinglePage = true
        pageControl.backgroundStyle = .automatic
        pageControl.allowsContinuousInteraction = false
        return pageControl
    }()

    let nameProduct: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .light)
        label.textColor = #colorLiteral(red: 0.06274509804, green: 0.231372549, blue: 0.3019607843, alpha: 1)
//        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    
    let compositionProduct: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2, green: 0.3058823529, blue: 0.3803921569, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 5
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
        
        
        setConstraints()
        
        pageControl.numberOfPages = images.count

        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Int(UIScreen.main.bounds.width) * images.count, height: 265)

        
        createImage(image: images[0], position: 0)
        createImage(image: images[1], position: 1)
        createImage(image: images[2], position: 2)
        createImage(image: images[3], position: 3)
        createImage(image: images[4], position: 4)
        
        
        energyLabel.text = "Энергетическая ценность: 234 Ккал на 100 гр."
        addButton.setTitle(nameTitleButton, for: .normal)
          
    }
    
    private func createImage(image: UIImage, position: CGFloat) {
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        scrollView.addSubview(imageView)
        let screenWidth = UIScreen.main.bounds.width
        imageView.frame = CGRect(x: screenWidth * position, y: 0, width: screenWidth, height: 265)
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
            scrollView.heightAnchor.constraint(equalToConstant: 265),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(nameProduct)
        nameProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameProduct.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameProduct.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40)
        ])
        
        
        view.addSubview(compositionProduct)
        compositionProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compositionProduct.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            compositionProduct.heightAnchor.constraint(equalToConstant: 100),
            compositionProduct.topAnchor.constraint(equalTo: nameProduct.bottomAnchor, constant: 40),
            compositionProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
//            compositionProduct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(energyLabel)
        energyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            energyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            energyLabel.heightAnchor.constraint(equalToConstant: 30),
            energyLabel.topAnchor.constraint(equalTo: compositionProduct.bottomAnchor, constant: 15),
            energyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(massProductLabel)
        massProductLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            massProductLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            massProductLabel.heightAnchor.constraint(equalToConstant: 30),
            massProductLabel.topAnchor.constraint(equalTo: compositionProduct.bottomAnchor, constant: 15),
            massProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}
