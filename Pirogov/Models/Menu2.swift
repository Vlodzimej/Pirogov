////
////  Menu2.swift
////  Pirogov
////
////  Created by Stanislav Seroukhov on 24.05.2024.
////
//
//import Foundation
//
//
//struct Product {
//    var name: String?
//    var ingredients: String?
//    var price: String?
//    var image: UIImage?
//}
//
//struct Group {
//    var name: String?
//    var products: [Product]?
//    
//    static func setupGroup() -> [Group] {
//        let groupPies = Group(products: Menu.setupPies())
//        let groupCakes = Group(products: Menu.setupCakes())
//        
//        let groups = [groupPies, groupCakes]
//        
//        return groups
//    }
//}
//
//
//
//struct MenuGroup {
//    var name: String
//    var products: [Menu]?
//    
//    static func createMenu() -> [Product] {
//       
//        let firstItem = Product(name: "Пироги")
//        let secondItem = Product(name: "Торты")
//        let thirdItem = Product(name: "Десерты")
//        let fouthItem = Product(name: "Выпечка")
//        let fifthItem = Product(name: "Киши")
//        let sixthItem = Product(name: "Пицца")
//        let seventhItem = Product(name: "Напитки")
//            
//        let menu: [Product] = [firstItem, secondItem, thirdItem, fouthItem, fifthItem, sixthItem, seventhItem]
//        
//        return menu
//    }
//}
//
//
//
//struct Menu {
//
//
//    //    Пироги
//    static func setupPies() -> [Product] {
//        let pie1 = Product(
//            name: "Пирог с кроликом и свежими грибами",
//            composition: "лук репчатый, мясо кролика, грибы шампиньоны, укроп.",
//            price: "2 250 ₽"
//        )
//        let pie2 = Product(
//            name: "Пирог рататуй с уткой",
//            composition: "баклажаны, перец болгарский, кабачки, морковь, грибы шампиньоны,  мясо утки.",
//            price: "2 850 ₽"
//        )
//        let pie3 = Product(
//            name: "Пирог с рыбой",
//            composition: "тесто дрожжевое (мука, яйцо, маргарин сливочный, молоко, дрожжи, сахар, соль),   начинка из отварной рыбки , с добавлением лука, соли, приправ и майонеза.",
//            price: "760 ₽"
//        )
//        let pie4 = Product(
//            name: "Пирог с сыром",
//            composition: "тесто (мука, яйцо, дрожжи, маргарин, соль, сахар), начинка(сыр адыгейский и твëрдые сорта сыров).",
//            price: "760 ₽"
//        )
//        let pie5 = Product(
//            name: "Пирог с капустой",
//            composition: "тесто дрожжевое (мука, молоко, маргарин сливочный, дрожжи, сахар, соль), начинка из рубленой капусты,пассированной моркови с добавлением репчатого лука и специй. * Пирог БЕЗ добавления майонеза.",
//            price: "600 ₽"
//        )
//        
//        let pies = [pie1, pie2, pie3, pie4, pie5]
//        
//        return pies
//    }
//    
//    
//    //    Торты
//    static func setupCakes() -> [Product] {
//        let cakes: [Product] = [
//            Product(
//                name: "Рулет меренговый",
//                composition: "яйцо, сахар, крахмал кукурузный, орехи миндаль, сыр Креметте, сливки, малина, крем-чиз и свежая голубика.",
//                price: "850 ₽"
//            ),
//            Product(
//                name: "Торт Медовый с лавандой и чёрной смородиной",
//                composition: "тесто (мука в/с, мёд, сахар-песок, масло сливочное, яйцо куриное, цветки лаванды, соль), прослойка (черная смородина, мёд, крахмал кукурузный), крем (сметана, сахар, мёд, ванилин). Внешний вид товара может отличаться от изображений, представленных на сайте.",
//                price: "700 ₽"
//            ),
//            Product(
//                name: "Торт «Красный бархат»",
//                composition: "тесто (мука в/с, яйцо куриное, сметана, сахар песок, какао, сода, соль, растительное масло), крем-чиз (сыр творожный «Креметте», масло сливочное, сахарная пудра, ванилин).",
//                price: "700 ₽"
//            ),
//            Product(
//                name: "Торт Наполеон классический по-домашнему",
//                composition: "Слоёное бездрожжевое тесто (мука в/с, соль, сахар, масло сливочное), заварной ванильный крем (молоко, мука в/с, сахар, яйцо куриное, масло сливочное).",
//                price: "600 ₽"
//            ),
//            Product(
//                name: "Торт «Три шоколада»",
//                composition: "Состав: шоколадный бисквит,мусс из шоколада (молочный,горький,белый)",
//                price: "1 050 ₽")
//        ]
//        return cakes
//    }
//}
