//
//  UserService.swift
//  TwitterClone
//
//  Created by 송여경 on 7/1/24.
//

import Firebase

struct UserService{
  static let shared = UserService()
  //firebase로부터 유저 정보를 snapshot 형태로 가져오는 것을 확인했음.
  func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    REF_USERS.child(uid).observeSingleEvent(of: .value){ snapshot in
      print("DEBUG: Snapshot is \(snapshot)")
      guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
      
      guard let username = dictionary["username"] as? String else { return }
      
      let user = User(uid: uid, dictionary: dictionary)
      
      print("DEBUG: Username is \(user.username)")
      print("DEBUG: Fullname is \(user.fullname)")
    }
  }
}
