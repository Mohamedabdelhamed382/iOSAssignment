//
//  ProductDetailsViewModel.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 04/06/2025.
//

import UIKit
import Combine

// MARK: - Product Details ViewModel

protocol ProductDetailsViewModelOutput {
    var title: String { get }
    var cancellable: Set<AnyCancellable> { get set }
    var product: Product { get }
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
}

typealias ProductDetailsViewModelProtocol = ViewModelLifecycle & ProductDetailsViewModelOutput
