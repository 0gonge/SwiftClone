//
//  Tweet.swift
//  TwitterClone
//
//  Created by 송여경 on 7/4/24.
//

import Foundation

struct Tweet {
  let caption: String
  let tweetID: String
  let uid: String
  let likes: Int
  var timestamp: Date! //변경 가능성 있음./  ! 해준 이유 - 초기화 시 반드시 값을 설정해 줄 것을 보장하지만, 초기화 전까지는 nil이 될 수 있음을 의미 그러나 초기화 시점에 값이 없으면 런타임 에러가 발생할 수 있음.
  let retweetCount: Int
  let user: User
  
  init(user: User, tweetID: String, dictionary: [String: Any]){
    self.user = user
    self.tweetID = tweetID
    
    self.caption = dictionary["caption"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
    self.likes = dictionary["likes"] as? Int ?? 0
    self.retweetCount = dictionary["retweets"] as? Int ?? 0
    
    if let timestamp = dictionary["timestamp"] as? Double{
      self.timestamp = Date(timeIntervalSince1970: timestamp)
    }
  }
}
