//
//  SignInPresenter.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

final class SignInPresenter {
    
    var view: SignInViewProtocol?
    var interactor: SignInInteractorProtocol?
    var router: SignInRouterProtocol?
    
}

extension SignInPresenter: SignInPresenterProtocol {
    
    func goToTabBar() {
        router?.goToTabBar()
    }
    
    func signInError(errors: [ErrorModel]) {
        view?.signInError(errors: errors)
    }
    
    func userData(email: String, password: String) {
        interactor?.userData(email: email, password: password)
    }
    
    func goToSignUp() {
        router?.goToSignUp()
    }
    
}
