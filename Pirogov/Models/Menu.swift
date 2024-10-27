//
//  Menu.swift
//  Pirogov
//
//  Created by Stanislav Seroukhov on 16.05.2024.
//

import Foundation
import UIKit

// Каждую модель лучше выносить в отдельный файл для удобства чтения. Также можно в один файл объединять логически взаимосвязанные сущности,
// как сделано в новом файле с моделью Products.

    //  MARK: - Структура для акций

struct Sale {
    static var imagesArray: [UIImage?] = [UIImage(named:"sale_bd"),
                                         UIImage(named: "sale_combo_1"),
                                         UIImage(named: "sale_combo_2"),
                                         UIImage(named: "sale_combo_3"),
                                         UIImage(named:"sale_combo_4")]
}


    //  MARK: - Структура для категорий меню

struct MenuProducts {
    var name: String
    
    static func fetchMenu() -> [MenuProducts] {
        
        let menu = [
            MenuProducts(name: "Пироги"),
            MenuProducts(name: "Торты"),
            MenuProducts(name: "Десерты"),
            MenuProducts(name: "Выпечка"),
            MenuProducts(name: "Киши"),
            MenuProducts(name: "Пицца"),
            MenuProducts(name: "Напитки")
        ]
        return menu
    }
}

//  MARK: - Структура для изображений товара
struct ImagesProduct {
    var images: [UIImage?]
}


    //  MARK: - Класс для корзины

struct CartItem {
    let product: Product
    var quantity: Int
}

class Cart {
    static let shared = Cart()
    
    private(set) var items: [CartItem] = []
    
    private init() {}
    
    //  Добавление товара
    func addItem(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(product: product, quantity: 1)
            items.append(newItem)
        }
    }

    // Удаление товара
    func removeItem(_ product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity -= 1
            if items[index].quantity == 0 {
            items.remove(at: index)
            }
        }
    }
    
    //  Обновление товара
    func updateItem(_ product: Product, quantity: Int) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity = quantity
            if items[index].quantity <= 0 {
                items.remove(at: index)
            }
        }
    }
    
    // Подсчет суммы всех товаров
    func totalPrice() -> Int {
        return items.reduce(0) { $0 + ($1.product.price) * ($1.quantity) }
    }
}


    //  MARK: - Структура для группировки товаров по категориям

struct GroupProducts {
    
    typealias Menu = [[Product]]
    
    static func setup(with products: [Product]) -> Menu {
        
        var nameGroup: Menu = []
        
        let pies = products.filter({ $0.type == .pie })
        let cakes = products.filter({ $0.type == .cake })
        let dessert = [Product]()
        let bakery = [Product]()
        let quiches = [Product]()
        let pizza = products.filter({ $0.type == .pizza })
        let drinks = [Product]()
        
        nameGroup.insert(contentsOf: [pies, cakes, dessert, bakery, quiches, pizza, drinks], at: 0)
        
        return nameGroup
    }
}





    //  MARK: - Pies
//
//var pies: [Product] = [
//    Product(id: 1,
//            name: "Пирог с кроликом и свежими грибами",
//            ingredients: "лук репчатый, мясо кролика, грибы шампиньоны, укроп.",
//            price: 2250,
//            image: ImagesProduct(images: [UIImage(named: "image1"),
//                                          UIImage(named: "image2"),
//                                          UIImage(named: "image3"),
//                                          UIImage(named: "image4"),
//                                          UIImage(named: "image5")
//                                         ])
//           ),
//    Product(id: 2,
//            name: "Пирог рататуй с уткой",
//            ingredients: "баклажаны, перец болгарский, кабачки, морковь, грибы шампиньоны, мясо утки.",
//            price: 2850,
//            image: ImagesProduct(images: [UIImage(named: "image1")])
//           ),
//    Product(id: 3,
//            name: "Пирог с рыбой",
//            ingredients: "тесто дрожжевое (мука, яйцо, маргарин сливочный, молоко, дрожжи, сахар, соль), начинка из отварной рыбки, с добавлением лука, соли, приправ и майонеза.",
//            price: 760,
//            image: ImagesProduct(images: [UIImage(named: "image1")])
//           ),
//    Product(id: 4,
//            name: "Пирог с сыром",
//            ingredients: "тесто (мука, яйцо, дрожжи, маргарин, соль, сахар), начинка(сыр адыгейский и твëрдые сорта сыров).",
//            price: 760,
//            image: ImagesProduct(images: [UIImage(named: "image1")])
//           ),
//    Product(id: 5,
//            name: "Пирог с капустой",
//            ingredients: "тесто дрожжевое (мука, молоко, маргарин сливочный, дрожжи, сахар, соль), начинка из рубленой капусты, пассированной моркови с добавлением репчатого лука и специй.\n * Пирог БЕЗ добавления майонеза.",
//            price: 600,
//            image: ImagesProduct(images: [UIImage(named: "image1")])
//           )
//]
//
//
//    //  MARK: - Cakes
//
//var cakes: [Product] = [
//    Product(id: 6,
//            name: "Рулет меренговый",
//            ingredients: "яйцо, сахар, крахмал кукурузный, орехи миндаль, сыр Креметте, сливки, малина, крем-чиз и свежая голубика.",
//            price: 850,
//            image: ImagesProduct(images: [UIImage(named: "cake1"),
//                                          UIImage(named: "rulet-merengovii-2"),
//                                          UIImage(named: "rulet-merengovii-3")
//                                         ])
//           ),
//    Product(id: 7,
//            name: "Торт Медовый с лавандой и чёрной смородиной",
//            ingredients: """
//тесто (мука в/с, мёд, сахар-песок, масло сливочное, яйцо куриное, цветки лаванды, соль), прослойка (черная смородина, мёд, крахмал кукурузный), крем (сметана, сахар, мёд, ванилин).
//Внешний вид товара может отличаться от изображений, представленных на сайте.
//""",
//            price: 700,
//            image: ImagesProduct(images: [UIImage(named: "cake1")])
//           ),
//    Product(id: 8,
//            name: "Торт «Красный бархат»",
//            ingredients: "тесто (мука в/с, яйцо куриное, сметана, сахар песок, какао, сода, соль, растительное масло), крем-чиз (сыр творожный «Креметте», масло сливочное, сахарная пудра, ванилин).",
//            price: 700,
//            image: ImagesProduct(images: [UIImage(named: "cake1")])
//           ),
//    Product(id: 9,
//            name: "Торт Наполеон классический по-домашнему",
//            ingredients: "слоёное бездрожжевое тесто (мука в/с, соль, сахар, масло сливочное), заварной ванильный крем (молоко, мука в/с, сахар, яйцо куриное, масло сливочное).",
//            price: 600,
//            image: ImagesProduct(images: [UIImage(named: "cake1")])
//           ),
//    Product(id: 10,
//            name: "Торт «Три шоколада»",
//            ingredients: "шоколадный бисквит, мусс из шоколада (молочный,горький,белый)",
//            price: 1050,
//            image: ImagesProduct(images: [UIImage(named: "cake1")])
//           )
//]
//
//    //  MARK: - Dessert
//
//var dessert: [Product] = [
//    Product(id: 11,
//            name: "Круглик мини с фисташковым кремом",
//            ingredients: "слоёное тесто собственного производства, заварной фисташковый крем, фисташковая глазурь.",
//            price: 80,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 12,
//            name: "Круглик мини с варёной сгущенкой",
//            ingredients: "слоёное тесто собственного производства, варёная сгущенка со сливками, молотый грецкий орех.",
//            price: 105,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 13,
//            name: "Круглик мини с шоколадным кремом",
//            ingredients: "слоёное тесто собственного производства, шоколадный ганаш ,горький шоколад, миндальные лепестки.",
//            price: 120,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 14,
//            name: "Круглик мини с клубничным кремом и черной смородиной",
//            ingredients: "слоёное тесто собственного производства, заварной клубничный крем, клубничная глазурь.",
//            price: 80,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 15,
//            name: "Круглик мини с лимонным кремом",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 105,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           )
//]
//
//    //  MARK: - Bakary
//
//var bakery: [Product] = [
//    Product(id: 16,
//            name: "Круассан с шоколадным кремом \"Набор из 3 шт.\"",
//            ingredients: "слоёное тесто собственного производства, заварной фисташковый крем, фисташковая глазурь.",
//            price: 400,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 17,
//            name: "Круассан с ягодным кремом \"Набор из 3 шт.\"",
//            ingredients: "слоёное тесто собственного производства, варёная сгущенка со сливками, молотый грецкий орех.",
//            price: 400,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 18,
//            name: "Круассан с лимонным курдом \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства, шоколадный ганаш ,горький шоколад, миндальные лепестки.",
//            price: 500,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 19,
//            name: "Дениш с вишней \"Набор из 2 шт.\"",
//            ingredients: "слоёное тесто собственного производства, заварной клубничный крем, клубничная глазурь.",
//            price: 290,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 20,
//            name: "Дениш с ананасом \"Набор из 2 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 290,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 21,
//            name: "Дениш с абрикосом \"Набор из 2 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 290,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 22,
//            name: "Круассан с миндальным кремом \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 560,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 23,
//            name: "Круассан с ветчиной и сыром \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 540,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 24,
//            name: "Косичка яблочная \"Набор из 2 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 350,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 25,
//            name: "Фаготтини с ветчиной и сыром \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 400,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 26,
//            name: "Фаготтини с курицей и грибами \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 400,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 27,
//            name: "Фаготтини с курицей и сыром \"Набор из 4 шт.\"",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 400,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           )
//]
//
//// Киши
//var quiches: [Product] = [
//    Product(id: 28,
//            name: "Киш с курицей и грибами",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 300,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 29,
//            name: "Киш с семгой и брокколи",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 300,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 30,
//            name: "Киш с курицей и грибами 1,1 кг.",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 1100,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 31,
//            name: "Киш с сёмгой и брокколи 1,1 кг.",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 1200,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//    Product(id: 32,
//            name: "Киш с копчёной курицей 1,1 кг.",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 1300,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           )
//]
//
//// Пицца
//var pizza: [Product] = [
//    // Добавить товары для категории пиццы
//]
//
//
//    //  MARK: - Drinks
//
//var drinks: [Product] = [
//    Product(id: 33,
//            name: "Морс (брусничный)",
//            ingredients: "слоёное тесто собственного производства ,лимонный заварной крем, лимонная глазурь.",
//            price: 94,
//            image: ImagesProduct(images: [UIImage(named: "karavai")])
//           ),
//]



// Функция для поиска товаров по названию или ингредиентам
//func searchProducts(keyword: String) -> [Product] {
//    let allProducts = pies + cakes + dessert
//    return allProducts.filter { product in
//        product.name.contains(keyword) == true || product.ingredients.contains(keyword) == true
//    }
//}

// Использование функции поиска
//let searchResult = searchProducts(keyword: "пирог")
//print(searchResult)
