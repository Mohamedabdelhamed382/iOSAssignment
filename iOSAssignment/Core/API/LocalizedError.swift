//
//  LocalizedError.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .invalidURL:
            return "Invalid URL"
        case .decodingError:
            return "Failed to parse data"
        case .serverError(let code):
            return "Server error. Code: \(code)"
        case .unknown(let err):
            return "An unknown error occurred: \(err.localizedDescription)"
        }
    }
}
