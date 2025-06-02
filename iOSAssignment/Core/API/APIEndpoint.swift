//
//  NetworkClient.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIEndpoint: URLRequestConvertible {
    case getProducts(limit: Int)

    private var baseURL: String {
        return "https://fakestoreapi.com"
    }

    private var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }

    private var queryItems: [URLQueryItem]? {
        switch self {
        case .getProducts(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    func asURLRequest() -> URLRequest? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems

        guard let url = components?.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
