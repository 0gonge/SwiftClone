//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 송여경 on 7/4/24.
//

import UIKit

class TweetCell: UICollectionViewCell {
  
  //MARK: - Properties
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
    label.text = "Some test caption"
    return label
  }()
  
  private let infoLabel = UILabel()
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect){
    super.init(frame: frame)
    
    backgroundColor = .white
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, 
                            paddingTop: 12, paddingLeft: 8)
    let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    //fillProportionally 옵션을 사용하면 Stack View 내의 서브뷰들이 각자의 고유 크기 비율에 맞게 공간을 분배/ 반응형 Good.
    stack.spacing = 4
    
    addSubview(
      stack
    )
    stack.anchor(
      top: profileImageView.topAnchor,
      left: profileImageView.rightAnchor,
      right: rightAnchor,
      paddingLeft: 12,
      paddingRight: 12
    )
    
    infoLabel.font = UIFont.systemFont(ofSize: 14)
    infoLabel.text = "Eddie Brock @venom"
    
    let underlineView = UIView()
    underlineView.backgroundColor = .systemGroupedBackground
    addSubview(underlineView)
    underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
  }
  
  required init?(coder: NSCoder){
    fatalError("init(corder: has not been implemented")
  }
}
