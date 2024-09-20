//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 송여경 on 7/4/24.
//

import UIKit

protocol TweetCellDelegate: class {
  func handleProfileImageTapped(_ cell: TweetCell)
}
//TweetCell에서 발생하는 이벤트를 처리할 수 있도록 요구사항을 정의하는 프로토콜
//클래스에서만 채택 가능 (구조체나 열거형에서는 사용할 수 없음)
//이렇게 클래스 전용 프로토콜로 설정을 해준 이유는 메모리 관리를 위한 weak 참조를 가능하게 하기 위해서다.
//순환참조 방지를 위해 클래스 전용 프로토콜을 사용해준다.
//TweetCell을 파라미터로 받아, 어떤 셀에서 프로필 이미지가 클릭되었는지 알 수 있다.

class TweetCell: UICollectionViewCell {
  
  //MARK: - Properties
  
  var tweet: Tweet? {
    didSet { configure() }
  }
  //tweet이 있을 경우에만 cell을 생성해주고 싶기 때문.
  
  weak var delegate: TweetCellDelegate?
  // 부모 자식 관계에서, retain cycle이 생길 수 있기 때문에 weak로 선언
  //feedcontroller에서 강한 참조를 delegate에 하고 있고, cell class에서 feedcontroller로 강한 참조를 하고 있다.
  //이 두개는 계속 참조가 되기 때문에 destroyed되지 못한다.
  //delegate이 필요한 곳에서 약한 참조를 해줘야 하는구나 하고 이해하자.
  
  private lazy var profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
    iv.addGestureRecognizer(tap)
    iv.isUserInteractionEnabled = true
    //userinteraction 활성화 true
    
    return iv
  }()
  
  private let captionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 0
    label.text = "코딩 잘하고 싶다 iOS 잘 하고 싶다"
    return label
  }()
  
  private lazy var commentButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "comment"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var retweetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "retweet"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "like"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var shareButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "share"), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
    return button
  }()
  
  private let infoLabel = UILabel()
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor,
                            paddingTop: 8, paddingLeft: 8)
    let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    stack.spacing = 4
    
    addSubview(stack)
    stack.anchor(top: profileImageView.topAnchor,
                 left: profileImageView.rightAnchor,
                 right: rightAnchor,
                 paddingLeft: 12,
                 paddingRight: 12)
    
    infoLabel.font = UIFont.systemFont(ofSize: 14)
    infoLabel.text = "songyeogyeong @502"
    
    let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
    
    actionStack.axis = .horizontal
    actionStack.spacing = 72
    
    addSubview(actionStack)
    actionStack.centerX(inView: self)
    actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    
    let underlineView = UIView()
    underlineView.backgroundColor = .systemGroupedBackground
    addSubview(underlineView)
    underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Selectors
  
  @objc func handleProfileImageTapped() {
    delegate?.handleProfileImageTapped(self)
  }
  
  @objc func handleCommentTapped() {
  }
  
  @objc func handleRetweetTapped() {
  }
  
  @objc func handleLikeTapped() {
  }
  
  @objc func handleShareTapped() {
  }
  
  func configure() {
    guard let tweet = tweet else { return } // optinal이기 때문에.
    let viewModel = TweetViewModel(tweet: tweet)
    captionLabel.text = tweet.caption
//    print("DEBUG: Tweet user is \(tweet.user.username)")
    //tweet model에 user 있고, user커스텀 구조 안에 username.
    //.으로 접근 가능해짐.
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    infoLabel.attributedText = viewModel.userInfoText
  }
}
