//
//  TabBarController.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 23.05.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    let logoView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainViewController = MainViewController()
    let shoppingCartConroller = ShoppingCartController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()

        self.navigationItem.titleView = logoView
    
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.itemPositioning = .automatic
        self.tabBar.tintColor = #colorLiteral(red: 0.06266801804, green: 0.2313786149, blue: 0.3019550741, alpha: 0.8709160003)
        
        self.navigationItem.hidesBackButton = true


    }
    
    //  MARK: - Create Tab Bar
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: mainViewController, title: "Меню", image: UIImage(systemName: "house")),
            generateVC(viewController: shoppingCartConroller, title: "Корзина", image: UIImage(systemName: "cart"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
}
