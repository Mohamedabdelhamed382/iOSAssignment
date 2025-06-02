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
}

struct Rating: Decodable {
    var rate: Double?
    var count: Int?
}
