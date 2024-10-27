//
//  Products.swift
//  Pirogov
//
//  Created by Владимир Амелькин on 27.10.2024.
//

import Foundation
import UIKit

// MARK: - ProductType
enum ProductType: String, Codable {
    case pie    = "PIE"
    case cake   = "CAKE"
    case pizza  = "PIZZA"
    case unknown
}

// MARK: - Структура для описания товара
struct Product: Decodable {
    /// Идентификатор
    var id: Int?
    /// Наименование
    let name: String
    /// Тип продукции
    let type: ProductType
    /// Состав
    let ingredients: String
    /// Цена
    var price: Int
    /// Ссылка на изоражение
    let imageLink: String?
    // С изображениями еще нужно разобраться, но совершенно точно, что на сервере должна будет хранится просто URL ссылка на изображение.
    // И для простоты пока лучше сделать одно изображение, я это пока сделал вот так, чтобы просто проект собирался.
    var image: ImagesProduct {
        .init(images: [UIImage(named: "image1")])
    }
    
    init(id: Int?, name: String, type: ProductType, ingredients: String, price: Int, imageLink: String? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.ingredients = ingredients
        self.price = price
        self.imageLink = imageLink
    }
}
