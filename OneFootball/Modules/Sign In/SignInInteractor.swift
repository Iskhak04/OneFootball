//
//  SignInInteractor.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import FirebaseAuth

final class SignInInteractor {
    
    var presenter: SignInPresenterProtocol?
    
}

extension SignInInteractor: SignInInteractorProtocol {
    
    func userData(email: String, password: String) {
        var errors = checkUserData(email: email, password: password)
        
        if errors.count == 0 {
            //try to sign in a user
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error == nil {
                    //user signed in successfully
                    self.presenter?.goToTabBar()
                } else {
                    //user with such email does not exist
                    if error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.EmailIsNotRegistered.rawValue))
                    }
                    //user exists, but password is entered wrong
                    else if error?.localizedDescription == "The password is invalid or the user does not have a password." {
                        errors.append(ErrorModel(errorType: .password, errorMessage: ErrorTypes.WrongPassword.rawValue))
                    }
                    
                    else {
                        print(error!.localizedDescription)
                    }
                    
                    self.presenter?.signInError(errors: errors)
                }
            }
        } else  {
            //error, send error status to presenter
            presenter?.signInError(errors: errors)
        }
    }
    
}

private func checkUserData(email: String, password: String) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    //email
    if email.isEmpty {
        errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.EmptyField.rawValue))
    } else if !isValidEmail(email: email) {
        errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.InvalidEmail.rawValue))
    }
    
    //password
    if password.isEmpty {
        errors.append(ErrorModel(errorType: .password, errorMessage: ErrorTypes.EmptyField.rawValue))
    }
    
    return errors
}

private func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    
    return emailPred.evaluate(with: email)
}
