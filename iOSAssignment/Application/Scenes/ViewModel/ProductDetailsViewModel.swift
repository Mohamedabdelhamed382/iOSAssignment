//
//  ProductDetailsViewModel.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 04/06/2025.
//

import Combine

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    
    // MARK: - Output
    let title: String = "Product Details"
    let viewState = PassthroughSubject<GeneralViewState, Never>()
    let endRefreshing = PassthroughSubject<Void, Never>()
    let products = CurrentValueSubject<[Product], Never>([])
    var cancellable = Set<AnyCancellable>()
    var product: Product

    init(product: Product) {
        self.product = product
    }
    
}
