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
        containerView.layer.cornerRadius = 10
    }
    
    func configureCell(model: Product) {
        if let image = model.image {
            productImage.loadImage(from: image, placeholder: UIImage(named: "placeholder"))
        }
        
        if let price = model.price {
            priceLabel.text = String(price)
        }
        
        titleLabel.text = model.title

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
