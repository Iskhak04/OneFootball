//
//  SignUpViewController.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    private lazy var signUpWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .systemBackground
        label.font = UIFont(name: Fonts.MontserratBold.rawValue, size: 30)
        return label
    }()
    
    private lazy var usernameTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Username"
        return view
    }()
    
    private lazy var emailTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Email"
        return view
    }()
    
    private lazy var passwordTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Password"
        view.isPasswordTextField = true
        return view
    }()
    
    private lazy var repeatPasswordTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Repeat password"
        view.isPasswordTextField = true
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Fonts.MontserratSemiBold.rawValue, size: 18)
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        resetBorderColors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .label
        navigationItem.hidesBackButton = true
        layout()
    }
    
    private func resetBorderColors() {
        if usernameTextFieldView.customErrorLabel.isHidden {
            usernameTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor

        }
        if emailTextFieldView.customErrorLabel.isHidden {
            emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor

        }
        if passwordTextFieldView.customErrorLabel.isHidden {
            passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor

        }
        if repeatPasswordTextFieldView.customErrorLabel.isHidden {
            repeatPasswordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor

        }
    }
    
    @objc private func signUpButtonClicked() {
        guard let username = usernameTextFieldView.customTextField.text, let email = emailTextFieldView.customTextField.text, let password = passwordTextFieldView.customTextField.text, let repeatPassword = repeatPasswordTextFieldView.customTextField.text else { return }
        
        resetInputs()
        
        //send new user data to presenter
        presenter?.newUserData(user: User(username: username, email: email, password: password, repeatPassword: repeatPassword))
    }
    
    private func resetInputs() {
        usernameTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor
        usernameTextFieldView.customErrorLabel.isHidden = true
        
        emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor
        emailTextFieldView.customErrorLabel.isHidden = true
        
        passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor
        passwordTextFieldView.customErrorLabel.isHidden = true
        
        repeatPasswordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemBackground.cgColor
        repeatPasswordTextFieldView.customErrorLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(signUpWordLabel)
        signUpWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameTextFieldView)
        usernameTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(signUpWordLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(110)
        }
        
        view.addSubview(emailTextFieldView)
        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(usernameTextFieldView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(110)
        }
        
        view.addSubview(passwordTextFieldView)
        passwordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(110)
        }
        
        view.addSubview(repeatPasswordTextFieldView)
        repeatPasswordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(110)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    func signUpError(errors: [ErrorModel]) {
        for i in 0..<errors.count {
            switch errors[i].errorType {
            case .email:
                emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                emailTextFieldView.customErrorLabel.text = errors[i].errorMessage
                emailTextFieldView.customErrorLabel.isHidden = false
            case .username:
                usernameTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                usernameTextFieldView.customErrorLabel.text = errors[i].errorMessage
                usernameTextFieldView.customErrorLabel.isHidden = false
            case .password:
                passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                passwordTextFieldView.customErrorLabel.text = errors[i].errorMessage
                passwordTextFieldView.customErrorLabel.isHidden = false
            case .repeatPassword:
                repeatPasswordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                repeatPasswordTextFieldView.customErrorLabel.text = errors[i].errorMessage
                repeatPasswordTextFieldView.customErrorLabel.isHidden = false
            }
        }
    }
    
}
