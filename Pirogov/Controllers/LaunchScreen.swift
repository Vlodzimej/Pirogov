//
//  LaunchScreen.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 13.06.2024.
//

import UIKit

// При добавлении final становится недоступным наследование этого класса, соответственно, метод тоже нельзя оверрайднуть.
// Возможно, вы часто видели такое и не понимали, для чего это делается. А это один из плюсов — изменение диспетчеризации
// на Direct Dispatch и, соответственно, улучшение производительности кода. Ну и защита от наследования, когда оно не нужно,
// например, при создании класса ViewController, единственного в приложении.
// https://habr.com/ru/companies/simbirsoft/articles/673636/

// В итоге должно быть:
// final class LaunchScreenViewController: UIViewController { ... }
//
// Ты у кого-то увидел такой метод отображения заставки или сам придумал? ))
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


//    MARK: - Settings Constraints

extension LaunchScreen {
    
    func setConstraints() {
        view.addSubview(imageView)
        /// Флаг translatesAutoresizingMaskIntoConstraints меняем при создании imageView, в блоке private lazy var imageView: UIImageView = { ... }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
