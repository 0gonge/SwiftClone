//
//  AuthService.swift
//  TwitterClone
//
//  Created by 송여경 on 6/24/24.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}
struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
         Auth.auth().signIn(withEmail: email, password: password, completion: completion)
     }
    //-> Void: 클로저의 반환 타입. Void는 반환 값이 없음을 의미. 즉, 클로저가 실행된 후 아무런 값을 반환하지 않는다.
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void){
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        //completion : error 와 콜백 함수 리턴임. 에러랑 데이터베이스 참조를 매개 변수로 받는다. 
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        //이미지를 가져와주는 부분이다. 압축을 하지 않으면 업로드 되는 시간이 굉장히 오래걸리게 된다.
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            //downloadURL필요
            storageRef.downloadURL{(url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email" : email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}

