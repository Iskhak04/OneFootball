//
//  SignInProtocols.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

//Conforms View, Presenter -> View
protocol SignInViewProtocol {
    func signInError(errors: [ErrorModel])
}

//Conforms Presenter, View -> Presenter, Interactor -> Presenter
protocol SignInPresenterProtocol {
    
    //View -> Presenter
    func goToSignUp()
    func userData(email: String, password: String)
    
    //Interactor -> Presenter
    func signInError(errors: [ErrorModel])
    func goToTabBar()
}

//Conforms Interactor, Presenter -> Interactor
protocol SignInInteractorProtocol {
    func userData(email: String, password: String)
}

//Conforms Router, Presenter -> Router
protocol SignInRouterProtocol {
    func goToSignUp()
    func goToTabBar()
}
