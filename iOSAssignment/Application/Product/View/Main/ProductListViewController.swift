//
//  ProductListViewController.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 31/05/2025.
//

import UIKit

class ProductListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var viewTypeSegmentedControl: UISegmentedControl!

    // MARK: - Properties
    private var viewModel: ProductsViewModelProtocol
    private var currentLayout: CollectionLayoutType = .list

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
        bindViewModel()
        configureSegmentedControl()
    }

    // MARK: - Actions
    @IBAction func viewTypeSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentLayout = .list
        case 1:
            currentLayout = .grid
        default:
            break
        }

        let newLayout = createLayout(for: currentLayout)
        UIView.transition(with: productCollectionView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.productCollectionView.setCollectionViewLayout(newLayout, animated: false)
        })
    }

    // MARK: - Helpers
    private func configureSegmentedControl() {
        viewTypeSegmentedControl.removeAllSegments()
        viewTypeSegmentedControl.insertSegment(withTitle: "List", at: 0, animated: false)
        viewTypeSegmentedControl.insertSegment(withTitle: "Grid", at: 1, animated: false)
        viewTypeSegmentedControl.selectedSegmentIndex = 0
    }
}

// MARK: - Binding
extension ProductListViewController {
    private func bindViewModel() {
        bindProducts()
        bindStoreProperties()
        bindViewState()
    }

    private func bindProducts() {
        viewModel.products
            .sinkOnMain { [weak self] _ in
                guard let self = self else { return }
                self.productCollectionView.reloadData()
            }.store(in: &viewModel.cancellable)
    }

    private func bindStoreProperties() {
        self.navigationItem.title = viewModel.title
    }

    private func bindViewState() {
        viewModel.viewState
            .sinkOnMain { [weak self] viewState in
                guard let self = self else { return }
                switch viewState {
                case .initial:
                    hideIndicator()
                case .loading:
                    showIndicator()
                case .error(let message):
                    hideIndicator()
                    show(errorMessage: message)
                case .noInternet:
                    hideIndicator()
                case .connecting:
                    hideIndicator()
                case .initialWithMessage(let message):
                    hideIndicator()
                    show(successMessage: message)
                }
            }.store(in: &viewModel.cancellable)
    }
}

// MARK: - Layout Setup
extension ProductListViewController {
    func createLayout(for type: CollectionLayoutType) -> UICollectionViewCompositionalLayout {
        switch type {
        case .grid:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .estimated(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            return UICollectionViewCompositionalLayout(section: section)

        case .list:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(120))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(120))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            return UICollectionViewCompositionalLayout(section: section)
        }
    }

    private func configureProductCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil),
                                       forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        productCollectionView.setCollectionViewLayout(createLayout(for: currentLayout), animated: false)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ProductListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
}
