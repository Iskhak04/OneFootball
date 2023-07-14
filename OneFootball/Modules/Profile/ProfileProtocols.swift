//
//  ProfileProtocols.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

//Conforms View, Presenter -> View
protocol ProfileViewProtocol {
    func userData(userData: UserModel)
}

//Conforms Presenter, View -> Presenter, Interactor -> Presenter
protocol ProfilePresenterProtocol {
    
    //View -> Presenter
    func fetchUserData()
    func changeProfileImage(newImage: UIImage)
    
    //Interactor -> Presenter
    func userData(userData: UserModel)
}

//Conforms Interactor, Presenter -> Interactor
protocol ProfileInteractorProtocol {
    func fetchUserData()
    func changeProfileImage(newImage: UIImage)
}

//Conforms Router, Presenter -> Router
protocol ProfileRouterProtocol {
    
}
