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
    var product: Product { get }
}

typealias ProductDetailsViewModelProtocol = ViewModelLifecycle & ProductDetailsViewModelOutput
