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
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(containerView)
    containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  //MARK: -
  @objc func handleDismissal() {
    
  }
}
