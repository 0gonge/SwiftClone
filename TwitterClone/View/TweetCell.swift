//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 송여경 on 7/4/24.
//

import UIKit

class TweetCell: UICollectionViewCell {
  
  //MARK: - Properties
  
  var tweet: Tweet? {
    didSet { configure() }
  }
  //tweet이 있을 경우에만 cell을 생성해주고 싶기 때문.
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
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
