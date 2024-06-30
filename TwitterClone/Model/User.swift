//
//  User.swift
//  TwitterClone
//
//  Created by 송여경 on 7/1/24.
//

import Foundation

struct User {
  let fullname: String
  let email: String
  let username: String
  var profileImageUrl: URL?
  let uid: String
  
  init(uid: String, dictionary: [String: AnyObject]){
    self.uid = uid
    //딕셔너리에서 "Fullname" 키의 값을 추출하고, 만약 값이 없거나 타입이 맞지 않으면 기본값으로 빈 문자열("")을 반환해주는 것이다.
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    
    if let profileImageUrlString = dictionary["profileImageUrl"] as? String{ //문자열 추출
      guard let url = URL(string: profileImageUrlString) else { return } //추출한 문자열을 URL로 변환
      self.profileImageUrl = url //변환된 url을 self로 설정.
    }
  }
}

