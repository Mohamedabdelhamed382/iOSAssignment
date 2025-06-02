//
//  APIService.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}
