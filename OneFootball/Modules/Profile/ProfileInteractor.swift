//
//  ProfileInteractor.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 13.07.23.
//

import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

final class ProfileInteractor {
    
    var presenter: ProfilePresenterProtocol?
    
    func uploadImage(userUid: String, image: UIImage) {
        let ref = Storage.storage().reference(withPath: "profileImages/\(userUid)")
        
        let data = image.compress(to: 1024)
        ref.putData(data, metadata: nil) { storageMetaData, error in
            if error == nil {
                print("successful upload")
                
                self.fetchUserData()
            } else {
                print("error uploading profile image: \(error!.localizedDescription)")
            }
        }
        
    }
    
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func changeProfileImage(newImage: UIImage) {
        let currentUser = Auth.auth().currentUser
        
        uploadImage(userUid: currentUser!.uid, image: newImage)
        
        
    }
    
    func fetchUserData() {
        let currentUser = Auth.auth().currentUser
        
        let databaseRef = Database.database().reference(withPath: "users/\(currentUser!.uid)/username")
                
        let storageRef = Storage.storage().reference(withPath: "profileImages/\(currentUser!.uid)")
        
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            
            storageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                if error == nil {
                    self.presenter?.userData(userData: UserModel(username: snapshot.value as! String, profileImage: UIImage(data: data!)!))
                } else {
                    print("error downloading profile image: \(error!.localizedDescription)")
                    self.presenter?.userData(userData: UserModel(username: snapshot.value as! String, profileImage: UIImage(named: "placeholder")!))
                }
            }
            
        }
        
        
    }
    
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }

    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
}
