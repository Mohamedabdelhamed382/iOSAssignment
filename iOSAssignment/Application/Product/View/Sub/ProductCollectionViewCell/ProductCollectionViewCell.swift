//
//  ProductCollectionViewCell.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryTextView: UITextView!
    
    static let identifier = "ProductCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryTextView.layer.cornerRadius = 10
    }

    func configureCell(model: Product) {
        if let image = model.image {
            productImage.loadImage(from: image, placeholder: UIImage(named: "placeholder"))
        }
        if let id = model.id {
            numberLabel.text = String(id)
        }
        if let price = model.price {
            priceLabel.text = String(price)
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        categoryTextView.text = model.category
    }
}
