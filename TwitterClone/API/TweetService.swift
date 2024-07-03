//
//  TweetService.swift
//  TwitterClone
//
//  Created by 송여경 on 7/3/24.
//

import Firebase

struct TweetService {
  static let shared = TweetService()
  
  func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void){
    guard let uid = Auth.auth().currentUser?.uid else { return }
    //함수가 반환된 후에도 유지되어야 하는 경우 escaping을 써준다. 비동기적 처리!!
    //이 클로저는 호출된 후 아무 값도 반환하지 않는다 Void.
    let values = 
    ["uid": uid,
     "timestamp": Int(NSDate().timeIntervalSince1970),
     "likes": 0,
     "retweets": 0,
     "caption": caption] as [String: Any]
    //Swift는 딕셔너리의 모든 값이 동일한 타입일 것을 요구하기 때문에, 값들이 혼합된 타입일 경우 [String: Any]로 캐스팅해야 한다는 것을 잊지 말자.
    
    REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
  }
  //completion이 여기에 매치된다.
  func fetchTweets(completion: @escaping([Tweet]) -> Void){
    var tweets = [Tweet]()
    //배열 초기화 빈 Tweet을 만듬.
    
    //observe - 데이터베이스에서 새로운 트윗이 추가될 때마다 호출
    REF_TWEETS.observe(.childAdded) { snapshot in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      let tweetID = snapshot.key
      let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
      tweets.append(tweet)
      completion(tweets)
    }
  }
}

