//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by 송여경 on 8/19/24.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
  //MARK: - Properties
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .twitterBlue
    
    view.addSubview(backButton)
    backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                      paddingTop: 42, paddingLeft: 16)
    backButton.setDimensions(width: 30, height: 30)
    
    return view
  }()
  //네비게이션 바를 없애주기로 햇기 때문에 커스텀 해서 만들어줘야 한다.
  
  private lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    iv.layer.borderColor = UIColor.white.cgColor
    iv.layer.borderWidth = 4
    return iv
  }()
  //초기화는 클로저를 통해 실행이 되고 클로저의 결과가 porfileImageView에 할당된다.
  // iv는 클로저 내에서 사용해 줄 임의의 변수
  // clipsToBounds는 이미지뷰의 경계를 넘는 부분을 자를지의 여부다.
  // 이미지가 로드되지 않았을 때를 위한 backgroundColor
  // layer.borderColor는 cgColor를 요구한다.
  private lazy var editProfileFollowButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Loading", for: .normal)
    //상태에 따라서 바뀌어야 함
    button.layer.borderColor = UIColor.twitterBlue.cgColor
    button.layer.borderWidth = 1.25
    button.setTitleColor(.twitterBlue, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
    
    addSubview(profileImageView)
    profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
    profileImageView.setDimensions(width: 80, height: 80)
    profileImageView.layer.cornerRadius = 80/2
    
    addSubview(editProfileFollowButton)
    editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
    editProfileFollowButton.setDimensions(width: 100, height: 36)
    editProfileFollowButton.layer.cornerRadius = 36 / 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: -
  @objc func handleDismissal() {
    
  }
  
  @objc func handleEditProfileFollow() {
    
  }
}
