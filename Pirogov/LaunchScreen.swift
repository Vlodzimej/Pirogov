//
//  LaunchScreen.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 13.06.2024.
//

import UIKit

class LaunchScreen: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "screen_logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setConstraints()
                
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            
            let vc = TabBarController()
            
            self.show(vc, sender: self)
        })
    }
}

extension LaunchScreen {
    
    func setConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
