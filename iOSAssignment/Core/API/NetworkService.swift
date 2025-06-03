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
            print("❌ No internet connection.")
            completion(.failure(.noInternet))
            return
        }

        guard let urlRequest = endpoint.asURLRequest() else {
            print("❌ Invalid URL request.")
            completion(.failure(.invalidURL))
            return
        }

        // 🔍 Print request details
        print("📤 Request:")
        print("URL: \(urlRequest.url?.absoluteString ?? "nil")")
        print("Method: \(urlRequest.httpMethod ?? "nil")")
        if let headers = urlRequest.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                print("❌ Request failed with error: \(err.localizedDescription)")
                completion(.failure(.unknown(err)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ No valid HTTP response.")
                completion(.failure(.serverError(statusCode: 0)))
                return
            }

            print("✅ Response Status Code: \(httpResponse.statusCode)")

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("📦 Response Body: \(responseString)")
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
                print("❌ Decoding failed: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
