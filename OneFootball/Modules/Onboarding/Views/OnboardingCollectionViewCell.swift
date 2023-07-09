//
//  OnboardingCollectionViewCell.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 07.07.23.
//

import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.MontserratRegular.rawValue, size: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 1
        return imageView
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var mainFeatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: Fonts.MontserratBold.rawValue, size: 35)
        return label
    }()
    
    lazy var mainFeatureDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.MontserratRegular.rawValue, size: 18)
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont(name: Fonts.MontserratSemiBold.rawValue, size: 18)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(frame.height / 2 + 125)
        }
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(frame.height / 2 - 100)
        }
        
        bottomView.addSubview(mainFeatureLabel)
        mainFeatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(86)
        }
        
        bottomView.addSubview(mainFeatureDescriptionLabel)
        mainFeatureDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainFeatureLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(80)
        }
        
        bottomView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(frame.width - 50)
        }
    }
}
