//
//  SignUpPresenter.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

final class SignUpPresenter {
    
    var view: SignUpViewProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func goToSignIn() {
        router?.goToSignIn()
    }
    
    func signUpError(errors: [ErrorModel]) {
        view?.signUpError(errors: errors)
    }
    
    func newUserData(user: User) {
        interactor?.newUserData(user: user)
    }
    
}
