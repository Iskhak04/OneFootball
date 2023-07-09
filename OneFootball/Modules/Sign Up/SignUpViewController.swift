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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .label
        navigationItem.hidesBackButton = true
        layout()
    }
    
    private func layout() {
        view.addSubview(signUpWordLabel)
        signUpWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
}
