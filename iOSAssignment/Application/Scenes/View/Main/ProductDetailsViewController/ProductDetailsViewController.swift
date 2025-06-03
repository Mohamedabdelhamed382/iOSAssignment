//
//  ProductDetailsViewController.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 04/06/2025.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productImage: UIImageView!

    // MARK: - Properties
    private var viewModel: ProductDetailsViewModelProtocol
    private var currentLayout: CollectionLayoutType = .list

    // MARK: - Init
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

// MARK: - Binding
extension ProductDetailsViewController {
    private func bindViewModel() {
        bindProducts()
        bindStoreProperties()
    }
    
    private func bindProducts() {
        productImage.loadImage(from: viewModel.product.image)

    }
    
    private func bindStoreProperties() {
        self.navigationItem.title = viewModel.title
    }
    
}
