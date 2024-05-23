//
//  Menu.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import Foundation
import UIKit

struct MenuProducts {
    var name: String
    
    static func fetchMenu() -> [MenuProducts] {
        
        let firstItem = MenuProducts(name: "Пироги")
        let secondItem = MenuProducts(name: "Торты")
        let thirdItem = MenuProducts(name: "Десерты")
        let fouthItem = MenuProducts(name: "Выпечка")
        let fifthItem = MenuProducts(name: "Киши")
        let sixthItem = MenuProducts(name: "Пицца")
        let seventhItem = MenuProducts(name: "Напитки")
            
        let menu: [MenuProducts] = [firstItem, secondItem, thirdItem, fouthItem, fifthItem, sixthItem, seventhItem]
        
        return menu
    }
}

struct Cakes {
    var name: String?
    var composition: String?
    var price: String?
    var image: UIImage?
    
    static func fetchCakes() -> [Cakes] {
        let cakes: [Cakes] = [
            Cakes(name: "Пирог с кроликом и свежими грибами", composition: "лук репчатый, мясо кролика, грибы шампиньоны, укроп", price: "2 250 ₽"),
            Cakes(name: "Пирог рататуй с уткой", composition: "баклажаны, перец болгарский, кабачки, морковь, грибы шампиньоны,  мясо утки", price: "2 850 ₽"),
            Cakes(name: "Пирог с рыбой", composition: "тесто дрожжевое (мука, яйцо, маргарин сливочный, молоко, дрожжи, сахар, соль),   начинка из отварной рыбки , с добавлением лука, соли, приправ и майонеза.", price: "760 ₽"),
            Cakes(name: "Пирог с сыром", composition: "тесто (мука, яйцо, дрожжи, маргарин, соль, сахар), начинка(сыр адыгейский и твëрдые сорта сыров)", price: "760 ₽"),
            Cakes(name: "Пирог с капустой", composition: "тесто дрожжевое (мука, молоко, маргарин сливочный, дрожжи, сахар, соль), начинка из рубленой капусты,пассированной моркови с добавлением репчатого лука и специй. * Пирог БЕЗ добавления майонеза", price: "600 ₽")
        ]
        return cakes
    }
}

