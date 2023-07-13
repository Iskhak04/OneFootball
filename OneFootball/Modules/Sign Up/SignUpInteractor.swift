//
//  SignUpInteractor.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

import FirebaseAuth

final class SignUpInteractor {
    
    var presenter: SignUpPresenterProtocol?
    
}

extension SignUpInteractor: SignUpInteractorProtocol {
    
    func newUserData(user: User) {
        var errors = checkUserData(user: user)
        
        if errors.count == 0 {
            //try to register a new user
            Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
                if authResult == nil {
                    errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.EmailIsRegistered.rawValue))
                    //email is already registered, send error status to presenter
                    self.presenter?.signUpError(errors: errors)
                } else {
                    //user is successfuly registered
                    print("registered")
                }
            }
        } else  {
            //error, send error status to presenter
            presenter?.signUpError(errors: errors)
        }
    }
    
}

private func checkUserData(user: User) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    
    //username
    if user.username.isEmpty {
        errors.append(ErrorModel(errorType: .username, errorMessage: ErrorTypes.EmptyField.rawValue))
    } else if user.username.rangeOfCharacter(from: characterSet.inverted) != nil {
        errors.append(ErrorModel(errorType: .username, errorMessage: ErrorTypes.InvalidUsername.rawValue))
    }
    
    //email
    if user.email.isEmpty {
        errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.EmptyField.rawValue))
    } else if !isValidEmail(email: user.email) {
        errors.append(ErrorModel(errorType: .email, errorMessage: ErrorTypes.InvalidEmail.rawValue))
    }
    
    //password
    if user.password.isEmpty {
        errors.append(ErrorModel(errorType: .password, errorMessage: ErrorTypes.EmptyField.rawValue))
    } else if !isValidPassword(password: user.password) {
        errors.append(ErrorModel(errorType: .password, errorMessage: ErrorTypes.InvalidPassword.rawValue))
    }
    
    //repeat password
    if user.repeatPassword.isEmpty {
        errors.append(ErrorModel(errorType: .repeatPassword, errorMessage: ErrorTypes.EmptyField.rawValue))
    } else if user.password != user.repeatPassword {
        
        if !errors.contains(where: { model in
            if model.errorType == .password {
                return true
            }
            return false
        }) {
            errors.append(ErrorModel(errorType: .repeatPassword, errorMessage: ErrorTypes.NotMatchingPasswords.rawValue))
            errors.append(ErrorModel(errorType: .password, errorMessage: ErrorTypes.NotMatchingPasswords.rawValue))
        } else {
            errors.append(ErrorModel(errorType: .repeatPassword, errorMessage: ErrorTypes.NotMatchingPasswords.rawValue))
        }
    }
    
    return errors
}

private func isValidPassword(password: String) -> Bool {
    let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
    let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

    return passwordPred.evaluate(with: password)
}

private func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
    
    return emailPred.evaluate(with: email)
}
