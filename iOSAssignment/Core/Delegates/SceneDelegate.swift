//
//  SceneDelegate.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 31/05/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vm = ProductsViewModel()
        let vc = ProductListViewController(viewModel: vm)
        let nav = BaseNavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

