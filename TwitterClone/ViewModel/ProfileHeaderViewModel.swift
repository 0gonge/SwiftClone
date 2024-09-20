//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by 송여경 on 9/8/24.
//

import UIKit


enum ProfileFilterOptions: Int, CaseIterable {
  case tweets //0
  case replies //1
  case likes //2
  
  var description: String {
    switch self {
    case .tweets: return "Tweets"
    case .replies: return "Tweets & Replies"
    case .likes: return "Likes"
    }
  }
}

//collectionViewCell들을 바꿔주기 위한 구조체다.
//case각각을 각각의 collectionview에 매치시켜줄 것이다.

//각 case에 대한 설명을 제공하는 description
//ProfileFilterOptions 열거형이 Int 타입을 채택하고 있기 때문에 각 케이스는 정수형 원시값을 가진다.
// CaseIterable : 열거형의 모든 케이스를 배열로 제공할 수 있도록 하는 프로토콜이다.
// 열거형의 모든 케이스에 대해 자동으로 배열을 생성하는 allCases 속성을 사용할 수 있음.
// 즉, ProfileFilterOptions.allCases를 호출하면 [.tweets, .replies, .likes]와 같은 배열을 얻음.
// description 각각의 case 마다 문자열을 반환해주고 있음
// let option = ProfileFilterOptions.tweets
// print(option.rawValue) // 0
// print(option.description) // "Tweets"

struct ProfileHeaderViewModel {
  
  private let user: User
  
  var followerString: NSAttributedString? {
    return attributedText(withValue: 0, text: "followers")
  }
  
  var followingString: NSAttributedString? {
    return attributedText(withValue: 2, text: "following")
  }
  
  var actionButtonTitle: String {
    //만약 유저가 자기자신이라면 edit profile이 떠야 하고,
    //아닐 경우, following/ not following 이 떠야 한다.
    if user.isCurrentUser {
      return "Edit Profile"
    } else {
      return "Follow"
    }
  }
  
  init(user: User){
    self.user = user
  }
  
  fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
    let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedTitle.append(NSAttributedString(string: "\(text)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor:UIColor.lightGray]))
    
    return attributedTitle
  }
  
}
