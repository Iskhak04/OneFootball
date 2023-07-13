//
//  SignUpProtocols.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

//Conforms View, Presenter -> View
protocol SignUpViewProtocol {
    func signUpError(errors: [ErrorModel])
}

//Conforms Presenter, View -> Presenter, Interactor -> Presenter
protocol SignUpPresenterProtocol {
    
    //View -> Presenter
    func newUserData(user: User)
    func goToSignIn()
    
    //Interactor -> Presenter
    func signUpError(errors: [ErrorModel])
}

//Conforms Interactor, Presenter -> Interactor
protocol SignUpInteractorProtocol {
    func newUserData(user: User)
}

//Conforms Router, Presenter -> Router
protocol SignUpRouterProtocol {
    func goToSignIn()
}
