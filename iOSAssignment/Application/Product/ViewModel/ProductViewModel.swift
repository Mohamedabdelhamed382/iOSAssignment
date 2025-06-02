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
    let selectedProduct = CurrentValueSubject<Product?, Never>(nil)
    let products = CurrentValueSubject<[Product], Never>([])
    var cancellable =  Set<AnyCancellable>()


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

    func tableWillDisplay(row: Int) {
        
    }

    func didSelectRowAt(index: Int) {
        guard products.value.indices.contains(index) else { return }
        selectedProduct.send(products.value[index])
    }

    // MARK: - Fetch Data
    private func fetchProducts() {
        viewState.send(.loading)
        networkService.request(endpoint: APIEndpoint.getProducts(limit: 7)) { [weak self] (result: Result<[Product], NetworkError>) in
            guard let self = self else {return}
                switch result {
                case .success(let fetchedProducts):
                    print("fetchedProducts", fetchedProducts)
                    self.products.send(fetchedProducts)
                    self.viewState.send(.initial)
                case .failure(let error):
                    self.viewState.send(.error(message: error.localizedDescription))
                }
        }
    }
}
