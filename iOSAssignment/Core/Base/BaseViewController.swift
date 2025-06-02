//
//  BaseViewController.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//


import UIKit
import Combine

protocol BaseViewControllerProtocol: AnyObject {
    func show(successMessage message: String)
    func show(errorMessage message: String)
}

enum GeneralViewState: Equatable {
    case initial
    case initialWithMessage(message: String)
    case loading
    case error(message: String)
    case noInternet
    case connecting
}


extension BaseViewControllerProtocol {

    func show(successMessage message: String) {
        guard let errorImage: UIImage = .init(systemName: "checkmark.square.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) else {return}
        AlertManager.shared.show(message: message, image: errorImage)
    }
    
    func show(errorMessage message: String) {
        guard let errorImage: UIImage = .init(systemName: "xmark.app.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) else {return}
        AlertManager.shared.show(message: message, image: errorImage)
    }
}


class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
    }

    //MARK: - Actions -
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Deinit -
    deinit {
        print("\(type(of: self)) is deinit, No memory leak found")
    }
}

extension BaseViewController {
    func showIndicator() {
        LoaderManager.shared.show()
    }
    func hideIndicator() {
        LoaderManager.shared.hide()
    }
}
