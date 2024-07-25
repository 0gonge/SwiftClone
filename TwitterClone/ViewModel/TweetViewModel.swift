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
  
  var timestamp: String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
    formatter.maximumUnitCount = 1
    //가장 큰 단위 하나만 표시해주기 위함이다.
    formatter.unitsStyle = .abbreviated
    //축약된 형태로 표현
    let now = Date()
    return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    //timestamp부터 지금까지의 시간의 차이를 반환해주는 것임. (상대적 표시)
  }
  
  var userInfoText: NSAttributedString {
    let title = NSMutableAttributedString(
      string: user.fullname,
      attributes: [.font: UIFont.boldSystemFont(
        ofSize: 14
      )]
    )
    title.append(
      NSAttributedString(
        string: " @\(user.username)",
        attributes: [
          .font: UIFont.systemFont(
            ofSize: 14
          ),
          .foregroundColor:UIColor.lightGray
        ]
      )
    )
    title.append(
      NSAttributedString(
        string: " ・ \(timestamp)",
        attributes: [
          .font: UIFont.systemFont(
            ofSize: 14
          ),
          .foregroundColor: UIColor.lightGray
        ]
      )
    )
    
    return title
  }
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.user = tweet.user
  }
}
