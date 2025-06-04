//
//  ProductDetailsViewController.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 04/06/2025.
//

import UIKit
import Cosmos

class ProductDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!

    // MARK: - Properties
    private var viewModel: ProductDetailsViewModelProtocol
    
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
        scrollView.delegate = self
    }
}

// MARK: - Binding
extension ProductDetailsViewController {
    private func bindViewModel() {
        bindProducts()
        bindStoreProperties()
    }
    
    private func bindProducts() {
        productImageView.loadImage(from: viewModel.product.image)
        numberLabel.text = viewModel.product.number
        titleLabel.text = viewModel.product.title
        priceLabel.text = viewModel.product.priceWithUSD
        descriptionTextView.text = viewModel.product.description
        categoryLabel.text = viewModel.product.category
        ratingView.rating = viewModel.product.ratingValue.rateValue
        numberOfReviewsLabel.text = viewModel.product.ratingValue.countValue
    }
    
    private func bindStoreProperties() {
        self.navigationItem.title = viewModel.title
    }
}

extension ProductDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let initialHeight: CGFloat = 250
        let newHeight = max(initialHeight - offsetY, 100)
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if !(offsetY + height >= contentHeight) {
            imageHeightConstraint.constant = newHeight

        }
        
        view.layoutIfNeeded()
    }
}
