//
//  NetworkService.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Foundation
import Network

class NetworkService: NetworkServiceProtocol {
    
    private let monitor = NWPathMonitor()
    private var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func request<T: Decodable>(
        endpoint: URLRequestConvertible,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard isConnected else {
            completion(.failure(.noInternet))
            return
        }

        guard let urlRequest = endpoint.asURLRequest() else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                completion(.failure(.unknown(err)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.serverError(statusCode: 0)))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
