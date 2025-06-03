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
    var product: Product

    init(product: Product) {
        self.product = product
    }
    
}
