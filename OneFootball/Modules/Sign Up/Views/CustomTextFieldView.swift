//
//  CustomTextFieldView.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 09.07.23.
//

import UIKit

final class CustomTextFieldView: UIView {
    
    var isPasswordTextField = false
    
    lazy var customWordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.MontserratMedium.rawValue, size: 20)
        return label
    }()
    
    lazy var customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.label.cgColor
        return view
    }()
    
    lazy var customTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = UIFont(name: Fonts.MontserratRegular.rawValue, size: 18)
        return textField
    }()
    
    lazy var revealButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(revealButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var customErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.isHidden = true
        label.font = UIFont(name: Fonts.MontserratMedium.rawValue, size: 16)
        return label
    }()
    
    @objc func revealButtonClicked() {
        if customTextField.isSecureTextEntry {
            revealButton.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
            customTextField.isSecureTextEntry = !customTextField.isSecureTextEntry
        } else {
            revealButton.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
            customTextField.isSecureTextEntry = !customTextField.isSecureTextEntry
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(customWordLabel)
        customWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        addSubview(customErrorLabel)
        customErrorLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(18)
        }
        
        addSubview(customBackgroundView)
        customBackgroundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(customErrorLabel.snp.top).offset(-10)
            make.height.equalTo(40)
        }
        
        if isPasswordTextField {
            customBackgroundView.addSubview(revealButton)
            revealButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
            
            customTextField.isSecureTextEntry = true
            customTextField.textContentType = .oneTimeCode
            
            customBackgroundView.addSubview(customTextField)
            customTextField.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalTo(revealButton.snp.left).offset(-5)
            }
        } else {
            customBackgroundView.addSubview(customTextField)
            customTextField.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
            }
        }

    }
}
