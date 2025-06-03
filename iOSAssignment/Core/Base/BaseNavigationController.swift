//
//  BaseNavigationController.swift
//  OnClean
//
//  Created by Mohamed abdelhamed on 15/01/2025.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    //MARK: - Properties -
    let image: UIImage = UIImage(named: "navArrowRight" ) ?? UIImage()
    let navBarStyle = UINavigationBar.appearance()
    let appearance = UINavigationBarAppearance()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture()
        self.handleAppearance()
        
    }
    
    //MARK: - Design -
    private func setupGesture() {
        self.view.semanticContentAttribute = .forceLeftToRight
    }
    
    //MARK: - Design -
    private func handleAppearance() {
        
        let appearance = UINavigationBarAppearance()
        let image = UIImage(systemName: "chevron.backward") // or your custom image
        
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        appearance.backgroundColor = .white
        
        navBarStyle.backgroundColor = .white
        navBarStyle.standardAppearance = appearance
        navBarStyle.compactAppearance = appearance
        navBarStyle.scrollEdgeAppearance = appearance
        
        self.navigationBar.tintColor = .black
    }
}
