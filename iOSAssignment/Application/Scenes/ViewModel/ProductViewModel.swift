//
//  ProductViewModel.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Combine
import Foundation

final class ProductsViewModel: ProductsListViewModelProtocol {
    
    // MARK: - Output
    let title: String = "Products"
    let viewState = PassthroughSubject<GeneralViewState, Never>()
    let endRefreshing = PassthroughSubject<Void, Never>()
    let products = CurrentValueSubject<[Product], Never>([])
    
    var cancellable = Set<AnyCancellable>()
    private var limit = 7
    private var canLoadMore = true

    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol

    // MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    // MARK: - Input methods
    func didLoad() {
        fetchProducts(isRefreshing: true)
    }

    func refresh() {
        canLoadMore = true
        limit = 7
        fetchProducts(isRefreshing: true)
    }

    func collectionViewWillDisplay(index: Int) {
        if index == products.value.count - 1 && canLoadMore {
            limit += 7
            fetchProducts(isRefreshing: false)
        }
    }

    // MARK: - Fetch Data
    private func fetchProducts(isRefreshing: Bool) {
        viewState.send(.loading)
        networkService.request(endpoint: APIEndpoint.getProducts(limit: limit)) { [weak self] (result: Result<[Product], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedProducts):
                self.viewState.send(.initial)
                self.endRefreshing.send()

                // Check if new data was added
                let currentCount = self.products.value.count
                if isRefreshing {
                    self.products.send(fetchedProducts)
                } else {
                    if fetchedProducts.count > currentCount {
                        self.products.send(fetchedProducts)
                    } else {
                        self.canLoadMore = false // Stop further fetching
                    }
                }

            case .failure(let error):
                self.viewState.send(.error(message: error.localizedDescription))
            }
        }
    }
}
