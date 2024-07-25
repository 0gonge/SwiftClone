//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by 송여경 on 7/26/24.
//

import UIKit

//compute properties에 도움이 된다.
//tweet cell의 일을 복잡하지 않게 줄여준다.

struct TweetViewModel {
  let tweet: Tweet
  let user: User
  
  var profileImageUrl: URL? {
    return user.profileImageUrl
  }
  
  var userInfoText: NSAttributedString {
    let title = NSMutableAttributedString(string: user.fullname,
                                          attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
    title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                               .foregroundColor:UIColor.lightGray]))
    return title
  }
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.user = tweet.user
  }
}
