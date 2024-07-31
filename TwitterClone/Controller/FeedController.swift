//
//  FeedController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/6/24.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController {
  
  //MARK: - Properties
  
  var user: User?{
    didSet{
      configureLeftBarButton()
    } //user있을 경우 동작함.
  }
  private var tweets = [Tweet](){
    didSet { collectionView.reloadData() }
  }
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchTweets()
  }
  //MARK: - API
  
  func fetchTweets(){
    TweetService.shared.fetchTweets {
      tweets in
      self.tweets = tweets
    }
  }
  //MARK: - Helpers
  func configureUI(){
    view.backgroundColor = .white
    
    collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
    
    let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    imageView.contentMode = .scaleAspectFit
    imageView.setDimensions(width: 44, height: 44)
    navigationItem.titleView = imageView
  }
  func configureLeftBarButton(){
    guard let user = user else { return } //user가 존재함을 보장.
    let profileImageView = UIImageView()
    profileImageView.setDimensions(width: 32, height: 32)
    profileImageView.layer.cornerRadius = 32 / 2
    profileImageView.layer.masksToBounds = true
    //cornerRadius를 사용하여 이미지의 모서리를 둥글게 할 때, masksToBounds를 true로 설정하지 않으면 모서리가 둥글게 잘리지 않는다. 클리핑을 해주어야 한다.
    //보통 프로필 이미지를 둥글게 만들기 위해 cornerRadius와 masksToBounds를 함께 사용.
    
    profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    //completed: nil은 이미지 다운로드가 완료된 후 추가적으로 실행할 코드가 없다는 것을 의미한다. 즉, 이미지를 설정하는 것만 필요하고, 완료 후 특별히 처리할 작업이 없기 때문에 콜백 함수를 지정하지 않은 것!
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
  }
}
//MARK: - UICollectionViewDelegate/DataSource
extension FeedController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return tweets.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    
    cell.delegate = self
    //내가 위임할게 라는 의미.
    //선언을 해줘야 동작하겠지?
    
    cell.tweet = tweets[indexPath.row]
    return cell
  }
  
  //컬렉션 뷰에서 셀을 재사용할 때, dequeueReusableCell 메서드가 반환하는 셀이 항상 TweetCell 타입임을 보장
  //nil을 반환할 가능성이 없다!!!
  //dequeueReusableCell 메서드는 항상 등록된 셀 타입을 반환하므로, 강제 언래핑(as!)을 통해 TweetCell로 안전하게 캐스팅
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
//cell크기 동적 조절 / 프로토콜

//MARK: - UIColectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
}

//MARK: - TweetCellDelegate
extension FeedController: TweetCellDelegate {
  func handleProfileImageTapped() {
    let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
    navigationController?.pushViewController(controller, animated: true)
  }
}

//extension FeedController : TweetCellDelegate {
//  func handleProfileImageTapped() {
//    let controller = ProfileController(collectionViewLayout: UICollectionViewLayout())
//    navigationController?.pushViewController(controller, animated: true)
//  }
//}
