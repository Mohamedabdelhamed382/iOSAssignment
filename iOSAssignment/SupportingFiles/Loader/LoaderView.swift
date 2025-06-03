//
//  LoaderView.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 03/06/2025.
//

import UIKit
import Lottie

final class LoaderView: UIView {
    
    // MARK: - Properties
    private let loaderView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "DefaultLoader") // Replace "loader" with your Lottie animation file name (without .json)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupInitialDesign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupInitialDesign()
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: topAnchor),
            loaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        loaderView.play()
    }
    
    private func setupInitialDesign() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .white.withAlphaComponent(0.9) // Optional, depending on your design
    }
    
    // MARK: - Deinit
    deinit {
        print("\(type(of: self)) is deinit, No memory leak found")
    }
    
    // MARK: - Public Methods
    func stop() {
        loaderView.stop()
        removeFromSuperview()
    }
    
    func start() {
        loaderView.play()
        isHidden = false
    }
}
