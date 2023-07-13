//
//  SignInModuleBuilder.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class SignInModuleBuilder {
    class func build() -> UIViewController {
        let view = SignInViewController()
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        let router = SignInRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
