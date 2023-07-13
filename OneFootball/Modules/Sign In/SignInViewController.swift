//
//  SignInViewController.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class SignInViewController: UIViewController {
    
    var presenter: SignInPresenterProtocol?
    
    private lazy var signInWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont(name: Fonts.MontserratBold.rawValue, size: 30)
        return label
    }()
    
    private lazy var emailTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Email"
        view.customTextField.delegate = self
        return view
    }()
    
    private lazy var passwordTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.customWordLabel.text = "Password"
        view.isPasswordTextField = true
        view.customTextField.delegate = self
        return view
    }()
    
    private lazy var signUpBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var doNotHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: Fonts.MontserratRegular.rawValue, size: 19)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.MontserratRegular.rawValue, size: 19)
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Fonts.MontserratSemiBold.rawValue, size: 18)
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        resetBorderColors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func resetBorderColors() {
        if emailTextFieldView.customErrorLabel.isHidden {
            emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.label.cgColor
        }
        if passwordTextFieldView.customErrorLabel.isHidden {
            passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    @objc private func signInButtonClicked() {
        guard let email = emailTextFieldView.customTextField.text, let password = passwordTextFieldView.customTextField.text else { return }
        
        resetInputs()
        
        //send user data to presenter
        presenter?.userData(email: email, password: password)
    }
    
    @objc private func signUpButtonClicked() {
        presenter?.goToSignUp()
    }
    
    private func resetInputs() {
        emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.label.cgColor
        emailTextFieldView.customErrorLabel.isHidden = true
        
        passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.label.cgColor
        passwordTextFieldView.customErrorLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(signInWordLabel)
        signInWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(emailTextFieldView)
        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(signInWordLabel.snp.bottom).offset(40)
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
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(180)
        }
        
        view.addSubview(signUpBackgroundView)
        signUpBackgroundView.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(316)
            make.height.equalTo(25)
        }
        
        signUpBackgroundView.addSubview(doNotHaveAnAccountLabel)
        doNotHaveAnAccountLabel.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
        }
        
        signUpBackgroundView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(doNotHaveAnAccountLabel.snp.right).offset(5)
            make.height.equalTo(23)
        }
    }

}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignInViewController: SignInViewProtocol {
    
    func signInError(errors: [ErrorModel]) {
        for i in 0..<errors.count {
            switch errors[i].errorType {
            case .email:
                emailTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                emailTextFieldView.customErrorLabel.text = errors[i].errorMessage
                emailTextFieldView.customErrorLabel.isHidden = false
            case .password:
                passwordTextFieldView.customBackgroundView.layer.borderColor = UIColor.systemRed.cgColor
                passwordTextFieldView.customErrorLabel.text = errors[i].errorMessage
                passwordTextFieldView.customErrorLabel.isHidden = false
            default:
                ()
            }
        }
    }
    
}
