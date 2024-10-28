//
//  ProfileController.swift
//  TwitterClone
//
//  Created by 송여경 on 7/26/24.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
  //MARK: - Properties
  private let user: User
  
  private var tweets = [Tweet](){
    didSet { collectionView.reloadData() }
  }
  
  //MARK: - Lifecycle
  
  init(user: User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  //profileController인스턴스를 초기화 할 때, 해당 화면에 표시할 사용자 user데이터를 외부로부터 전달받아서 사용한다.
  //이 사용자는 프로필 화면에 필요한 정보를 제공한다.
  //전달받은 user객체를 profilecontroller의 user속성에 저장한다.
  //그리고 부모 클래스인 UICollectionViewLayout의 초기화 메서드를 호출하여, 컬렉션 뷰를 초기화 한다. 중요함!
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    fetchTweets()
    
    print("DEBUG: User is \(user.username)")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.barStyle = .black
    //상태바의 배경색이 어두울 때, 텍스트는 흰색으로 표현이 된다.
    navigationController?.navigationBar.isHidden = true
    
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  //흠.. 근데 안된다
  
  //MARK: - API
  
  func fetchTweets() {
    TweetService.shared.fetchTweets(forUser: user) { tweets in
      self.tweets = tweets
    }
  }
  //MARK: - Helpers
  
  func configureCollectionView() {
    collectionView.backgroundColor = .white
    collectionView.contentInsetAdjustmentBehavior = .never
    
    collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
  }
}
//MARK: - UICollectionViewDataSource

extension ProfileController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tweets.count
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
    cell.tweet = tweets[indexPath.row]
    return cell
  }
}
//cell.tweet = tweets[indexPath.row]: 해당 위치의 트윗 데이터를 셀에 설정
//indexPath.row: 현재 셀의 위치

//MARK: - UICollectionViewDelegate

extension ProfileController {
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
    header.user = user
    header.delegate = self
    return header
  }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 350)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 120)
  }
}
//MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
  func handleDismissal() {
    print("DEBUG: HandleDismiss profile from profileController .. ")
    navigationController?.popViewController(animated: true)
  }
}
//navigation관련 로직은 UIViewController를 상속받고 있는 ProfileController에서 해주도록 명확하게 extention으로 구현
