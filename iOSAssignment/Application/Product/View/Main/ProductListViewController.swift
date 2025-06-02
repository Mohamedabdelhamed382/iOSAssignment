//
//  ProductListViewController.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 31/05/2025.
//

import UIKit

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOut
    @IBOutlet weak var productCollectionView: UICollectionView!

    // MARK: - Properties
    private var viewModel: ProductsViewModelProtocol

    // MARK: - Init
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        configureProductCollectionView()
        bindingWithObserverProperties()
        bindingWithStoreProperties()
        bindingWithViewStateObserverProperties()
    }
}

//MARK: - Binding
extension ProductListViewController {
    func bindingWithObserverProperties() {
        viewModel.products
            .sinkOnMain { [weak self] _ in
                guard let self = self else {return}
                self.productCollectionView.reloadData()
            }.store(in: &viewModel.cancellable)
    }
    
    func bindingWithStoreProperties() {
        self.navigationItem.title = viewModel.title
    }
    
    func bindingWithViewStateObserverProperties() {
        viewModel.viewState.sinkOnMain { [weak self] viewState in
            guard let self = self else {return}
            switch viewState {
            case .initial:
                hideIndicator()
            case .loading:
                showIndicator()
            case .error(message: let message):
                hideIndicator()
                show(errorMessage: message)
            case .noInternet:
                hideIndicator()
                print("noInternet")
            case .connecting:
                hideIndicator()
                print("connecting")
            case .initialWithMessage(message: let message):
                hideIndicator()
                show(successMessage: message)
            }
        }.store(in: &viewModel.cancellable)
    }
}

extension ProductListViewController {
    func configureProductCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil),
                                       forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}

extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let product = viewModel.products.value[indexPath.row]
        cell.configureCell(model: product)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 16
        return CGSize(width: width, height: 220)
    }
}
