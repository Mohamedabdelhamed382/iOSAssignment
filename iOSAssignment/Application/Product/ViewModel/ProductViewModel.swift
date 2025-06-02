//
//  ProductViewModel.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Combine
import Foundation

final class ProductsViewModel: ProductsViewModelProtocol {
    
    // MARK: - Output
    let title: String = "Products"
    let viewState = PassthroughSubject<GeneralViewState, Never>()
    let endRefreshing = PassthroughSubject<Void, Never>()
    let selectedProduct = CurrentValueSubject<Product?, Never>(nil)
    let products = CurrentValueSubject<[Product], Never>([])
    var cancellable =  Set<AnyCancellable>()
    var limit = 7

    // MARK: - Dependencies
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Init
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Input methods
    func didLoad() {
        fetchProducts()
    }

    func willAppear() {
        
    }

    func collectionViewWillDisplay(index: Int) {
        
    }
    
    func refresh() {
        fetchProducts()
    }

    func didSelectRowAt(index: Int) {
        guard products.value.indices.contains(index) else { return }
        selectedProduct.send(products.value[index])
    }

    // MARK: - Fetch Data
    private func fetchProducts() {
        viewState.send(.loading)
        networkService.request(endpoint: APIEndpoint.getProducts(limit: limit)) { [weak self] (result: Result<[Product], NetworkError>) in
            guard let self = self else {return}
                switch result {
                case .success(let fetchedProducts):
                    viewState.send(.initial)
                    products.send(fetchedProducts)
                    endRefreshing.send()
                case .failure(let error):
                    self.viewState.send(.error(message: error.localizedDescription))
                }
        }
    }
}
