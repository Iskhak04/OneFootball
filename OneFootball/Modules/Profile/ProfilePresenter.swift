//
//  ProfilePresenter.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class ProfilePresenter {
    
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func changeProfileImage(newImage: UIImage) {
        interactor?.changeProfileImage(newImage: newImage)
    }
    
    func userData(userData: UserModel) {
        view?.userData(userData: userData)
    }
    
    func fetchUserData() {
        interactor?.fetchUserData()
    }
    
}
