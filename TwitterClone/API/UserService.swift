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
  //데이터를 가져오는 작업이 완료되면 호출되어 결과를 전달하는 것임.
  //escaping은 클로저가 함수 본문이 끝난 후에도 실행될 수 있음을 뜻함. -> 비동기적 처리
  
  func fetchUser(completion: @escaping(User) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    REF_USERS.child(uid).observeSingleEvent(of: .value){ snapshot in
      guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
      
      guard let username = dictionary["username"] as? String else { return }
      
      let user = User(uid: uid, dictionary: dictionary)
      completion(user)
    }
  }
}
