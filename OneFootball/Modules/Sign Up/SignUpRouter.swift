//
//  SignUpRouter.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

import UIKit

final class SignUpRouter {
    
    weak var viewController: UIViewController?
    
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func goToSignIn() {
        //push to sign in page
        viewController?.navigationController?.pushViewController(SignInModuleBuilder.build(), animated: false)
        //remove sign up page from navigation stack
        viewController?.navigationController?.viewControllers.removeFirst(1)
    }
    
}
