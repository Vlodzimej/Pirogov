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



struct Product {
    var name: String?
    var ingredients: String?
    var price: Int?
    var image: ImagesProduct
}

struct ImagesProduct {
    var images: [UIImage?]
}


struct GroupProducts {
    var name: String
    var products: [Product]
    
    static func setup() -> [GroupProducts] {
        
        var nameGroup:[GroupProducts] = []
        
        nameGroup.append(pies)
        nameGroup.append(cakes)
        nameGroup.append(dessert)
        
        return nameGroup
    }
}





//MARK: - Pies

var pies = GroupProducts(name: "Пироги", products: [
    Product(name: "Пирог с кроликом и свежими грибами",
            ingredients: "лук репчатый, мясо кролика, грибы шампиньоны, укроп.",
            price: 2250,
            image: ImagesProduct(images: [UIImage(named: "image1"),
                                          UIImage(named: "image2"),
                                          UIImage(named: "image3"),
                                          UIImage(named: "image4"),
                                          UIImage(named: "image5")
                                         ])
           ),
    Product(name: "Пирог рататуй с уткой",
            ingredients: "баклажаны, перец болгарский, кабачки, морковь, грибы шампиньоны, мясо утки.",
            price: 2850,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Пирог с рыбой",
            ingredients: "тесто дрожжевое (мука, яйцо, маргарин сливочный, молоко, дрожжи, сахар, соль), начинка из отварной рыбки, с добавлением лука, соли, приправ и майонеза.",
            price: 760,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Пирог с сыром",
            ingredients: "тесто (мука, яйцо, дрожжи, маргарин, соль, сахар), начинка(сыр адыгейский и твëрдые сорта сыров).",
            price: 760,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Пирог с капустой",
            ingredients: "тесто дрожжевое (мука, молоко, маргарин сливочный, дрожжи, сахар, соль), начинка из рубленой капусты, пассированной моркови с добавлением репчатого лука и специй.\n * Пирог БЕЗ добавления майонеза.",
            price: 600,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           )
])


// MARK: - Cakes

var cakes = GroupProducts(name: "Торты", products: [
    Product(name: "Рулет меренговый",
            ingredients: "яйцо, сахар, крахмал кукурузный, орехи миндаль, сыр Креметте, сливки, малина, крем-чиз и свежая голубика.",
            price: 850,
            image: ImagesProduct(images: [UIImage(named: "rulet-merengovii-1"),
                                          UIImage(named: "rulet-merengovii-2"),
                                          UIImage(named: "rulet-merengovii-3")
                                         ])
           ),
    Product(name: "Торт Медовый с лавандой и чёрной смородиной",
            ingredients: "тесто (мука в/с, мёд, сахар-песок, масло сливочное, яйцо куриное, цветки лаванды, соль), прослойка (черная смородина, мёд, крахмал кукурузный), крем (сметана, сахар, мёд, ванилин). Внешний вид товара может отличаться от изображений, представленных на сайте.",
            price: 700,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Торт «Красный бархат»",
            ingredients: "тесто (мука в/с, яйцо куриное, сметана, сахар песок, какао, сода, соль, растительное масло), крем-чиз (сыр творожный «Креметте», масло сливочное, сахарная пудра, ванилин).",
            price: 700,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Торт Наполеон классический по-домашнему",
            ingredients: "слоёное бездрожжевое тесто (мука в/с, соль, сахар, масло сливочное), заварной ванильный крем (молоко, мука в/с, сахар, яйцо куриное, масло сливочное).",
            price: 600,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Торт «Три шоколада»",
            ingredients: "шоколадный бисквит, мусс из шоколада (молочный,горький,белый)",
            price: 1050,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           )
])


// MARK: - Dessert

var dessert = GroupProducts(name: "Дессерты", products: [
    Product(name: "Круглик мини с фисташковым кремом",
            ingredients: "слоёное тесто собственного производства, заварной фисташковый крем, фисташковая глазурь.",
            price: 80,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Круглик мини с варёной сгущенкой",
            ingredients: "слоёное тесто собственного производства, варёная сгущенка со сливками, молотый грецкий орех.",
            price: 105,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Круглик мини с шоколадным кремом",
            ingredients: "слоёное тесто собственного производства, шоколадный ганаш ,горький шоколад, миндальные лепестки.",
            price: 120,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Круглик мини с клубничным кремом и черной смородиной",
            ingredients: "слоёное тесто собственного производства, заварной клубничный крем, клубничная глазурь.",
            price: 80,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           ),
    Product(name: "Круглик мини с лимонным кремом",
            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
            price: 105,
            image: ImagesProduct(images: [UIImage(named: "image1")])
           )
])






//struct Pies {
//    var name: String?
//    var ingredients: String?
//    var price: Int?
//    var image: UIImage?
//    
//    static func fetchPies() -> [Pies] {
//        let pies: [Pies] = [
//            Pies(name: "Пирог с кроликом и свежими грибами",
//                 ingredients: "лук репчатый, мясо кролика, грибы шампиньоны, укроп.",
//                 price: 2250,
//                 image: UIImage(named: "image1")),
//            Pies(name: "Пирог рататуй с уткой",
//                 ingredients: "баклажаны, перец болгарский, кабачки, морковь, грибы шампиньоны,  мясо утки.",
//                 price: 2850,
//                 image: UIImage(named: "image1")),
//            Pies(name: "Пирог с рыбой",
//                 ingredients: "тесто дрожжевое (мука, яйцо, маргарин сливочный, молоко, дрожжи, сахар, соль), начинка из отварной рыбки , с добавлением лука, соли, приправ и майонеза.",
//                 price: 760,
//                 image: UIImage(named: "image1")),
//            Pies(name: "Пирог с сыром",
//                 ingredients: "тесто (мука, яйцо, дрожжи, маргарин, соль, сахар), начинка(сыр адыгейский и твëрдые сорта сыров).",
//                 price: 760,
//                 image: UIImage(named: "image1")),
//            Pies(name: "Пирог с капустой",
//                 ingredients: "тесто дрожжевое (мука, молоко, маргарин сливочный, дрожжи, сахар, соль), начинка из рубленой капусты,пассированной моркови с добавлением репчатого лука и специй. * Пирог БЕЗ добавления майонеза.",
//                 price: 600,
//                 image: UIImage(named: "image1"))
//        ]
//        return pies
//    }
//}
//
//
//struct Cakes {
//    var name: String?
//    var ingredients: String?
//    var price: Int?
//    var image: UIImage?
//    
//    static func fetchCakes() -> [Cakes] {
//        let cakes: [Cakes] = [
//            Cakes(name: "Рулет меренговый",
//                  ingredients: "яйцо, сахар, крахмал кукурузный, орехи миндаль, сыр Креметте, сливки, малина, крем-чиз и свежая голубика.",
//                  price: 850,
//                  image: UIImage(named: "cake1")),
//            Cakes(name: "Торт Медовый с лавандой и чёрной смородиной",
//                  ingredients: "тесто (мука в/с, мёд, сахар-песок, масло сливочное, яйцо куриное, цветки лаванды, соль), прослойка (черная смородина, мёд, крахмал кукурузный), крем (сметана, сахар, мёд, ванилин). Внешний вид товара может отличаться от изображений, представленных на сайте.",
//                  price: 700,
//                  image: UIImage(named: "cake1")),
//            Cakes(name: "Торт «Красный бархат»",
//                  ingredients: "тесто (мука в/с, яйцо куриное, сметана, сахар песок, какао, сода, соль, растительное масло), крем-чиз (сыр творожный «Креметте», масло сливочное, сахарная пудра, ванилин).",
//                  price: 700,
//                  image: UIImage(named: "cake1")),
//            Cakes(name: "Торт Наполеон классический по-домашнему",
//                  ingredients: " cлоёное бездрожжевое тесто (мука в/с, соль, сахар, масло сливочное), заварной ванильный крем (молоко, мука в/с, сахар, яйцо куриное, масло сливочное).",
//                  price: 600,
//                  image: UIImage(named: "cake1")),
//            Cakes(name: "Торт «Три шоколада»",
//                  ingredients: "шоколадный бисквит, мусс из шоколада (молочный, горький, белый)",
//                  price: 1050,
//                  image: UIImage(named: "cake1"))
//        ]
//        return cakes
//    }
//}




