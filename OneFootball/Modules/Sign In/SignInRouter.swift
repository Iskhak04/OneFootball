//
//  SignInRouter.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class SignInRouter {
    
    weak var viewController: UIViewController?
    
}

extension SignInRouter: SignInRouterProtocol {
    
    func goToSignUp() {
        //push to sign up page
        viewController?.navigationController?.pushViewController(SignUpModuleBuilder.build(), animated: false)
        //remove sign in page from navigation stack
        viewController?.navigationController?.viewControllers.removeFirst(1)
    }
    
}
