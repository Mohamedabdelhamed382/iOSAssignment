//
//  TopAlert.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//

import UIKit

class TopAlert: UIView {

    //MARK: - IBOutlets -
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    
    //MARK: - Initializer -
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetUp()
        self.setupInitialDesign()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetUp()
        self.setupInitialDesign()
    }
    
    private func xibSetUp() {
        let view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    private func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TopAlert", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
        
    }
    
    //MARK: - Design -
    private func setupInitialDesign() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.tintColor = .blue
    }
    
    //MARK: - Data -
    func set(message: String, image: UIImage) {
        self.label.text = message
        self.imageView.image = image
    }
    
    //MARK: - Deinit -
    deinit {
        print("\(type(of: self)) is deinit, No memory leak found")
    }
    
}
