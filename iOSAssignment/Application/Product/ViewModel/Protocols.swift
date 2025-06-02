//
//  Protocols.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 01/06/2025.
//

import Combine

protocol ProductsViewModelInput {
    func didLoad()
    func willAppear()
    func tableWillDisplay(row: Int)
    func didSelectRowAt(index: Int)
}

protocol ProductsViewModelOutput {
    var title: String { get }
    var cancellable: Set<AnyCancellable> {get set}
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
    var selectedProduct: CurrentValueSubject<Product?, Never> { get }
    var products: CurrentValueSubject<[Product], Never> { get }
}

typealias ProductsViewModelProtocol = ProductsViewModelInput & ProductsViewModelOutput
