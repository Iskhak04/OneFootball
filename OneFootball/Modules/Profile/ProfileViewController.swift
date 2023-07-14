//
//  ProfileViewController.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change image", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(changePhotoButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Placehodler"
        label.font = UIFont(name: Fonts.MontserratBold.rawValue, size: 25)
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchUserData()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    @objc private func saveButtonClicked() {
        presenter?.changeProfileImage(newImage: userImageView.image!)
    }
    
    @objc private func changePhotoButtonClicked() {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func layout() {
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        view.addSubview(changePhotoButton)
        changePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(changePhotoButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
    func userData(userData: UserModel) {
        userImageView.image = userData.profileImage
        usernameLabel.text = userData.username
    }
    
}
