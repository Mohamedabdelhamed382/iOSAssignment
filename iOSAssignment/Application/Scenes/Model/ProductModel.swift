//
//  Model.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//


import Foundation

struct Product: Decodable {
    var id: Int
    var title: String?
    private var price: Double?
    var description: String?
    var category: String?
    var image: String?
    private var rating: Rating?
    var priceWithUSD: String  {
        return String(price ?? 0.0) + "USD"
    }
    var number: String  {
        return "#\(id)"
    }
    
    var ratingValue: Rating  {
        return rating ?? .init()
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
    private var rate: Double?
    private var count: Int?
    
    var rateValue: Double {
        return rate ?? 0.0
    }
    
    var countValue: String {
        return String(count ?? 0)
    }
    
    enum CodingKeys: CodingKey {
        case rate
        case count
    }
}
