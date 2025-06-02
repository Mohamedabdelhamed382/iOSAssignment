//
//  NetworkClientProtocol.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest?
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        endpoint: URLRequestConvertible,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

