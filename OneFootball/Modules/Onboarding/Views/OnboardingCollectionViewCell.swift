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
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var mainFeatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Store your NFT collection"
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    lazy var mainFeatureDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a subscript that describes this feature in a better way"
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(frame.height / 2 - 30)
        }
        
        bottomView.addSubview(mainFeatureLabel)
        mainFeatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        bottomView.addSubview(mainFeatureDescriptionLabel)
        mainFeatureDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainFeatureLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
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
