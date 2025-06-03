//
//  ProductCollectionViewCell.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//

import UIKit
import Cosmos

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    static let identifier = "ProductCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        containerView.layer.cornerRadius = 10
    }
    
    func configureCell(model: Product) {
        productImage.loadImage(from: model.image)
        priceLabel.text = model.priceWithUSD
        titleLabel.text = model.title
    }
}
