//
//  Model.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//


import Foundation

struct Product: Decodable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
    var priceWithUSD: String  {
        return String(price ?? 0.0) + "USD"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
}

struct Rating: Decodable {
    var rate: Double?
    var count: Int?
}
