//
//  ErrorTypes.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 11.07.23.
//

enum ErrorTypes: String {
    case EmptyField = "Empty field"
    
    //errors related to username
    case UsernameIsTaken = "This username is already taken"
    case InvalidUsername = "Username must consist of letters and numbers only"
    
    //errors related to email
    case EmailIsRegistered = "This email is already registered"
    case EmailIsNotRegistered = "This email is not registered"
    case InvalidEmail = "Invalid email"
    
    //errors related to password
    case InvalidPassword = "Password must be at least 8 characters long"
    case NotMatchingPasswords = "Passwords should match"
    case WrongPassword = "Wrong password"
    
}
