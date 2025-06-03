//
//  ProductsListViewModel.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 04/06/2025.
//

import UIKit
import Combine

// MARK: - Products List ViewModel
protocol ProductsListViewModelInput: ViewModelLifecycle {
    func collectionViewWillDisplay(index: Int)
    func refresh()
}

extension ProductsListViewModelInput {
    func collectionViewWillDisplay(index: Int) {}
    func refresh() {}
}

protocol ProductsListViewModelOutput {
    var title: String { get }
    var cancellable: Set<AnyCancellable> { get set }
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
    var products: CurrentValueSubject<[Product], Never> { get }
    var endRefreshing: PassthroughSubject<Void, Never> { get }
}

typealias ProductsListViewModelProtocol = ProductsListViewModelInput & ProductsListViewModelOutput
