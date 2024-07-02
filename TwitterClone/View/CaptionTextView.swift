//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by 송여경 on 7/3/24.
//

import UIKit

class CaptionTextView: UITextView {
  
  //MARK: - Properties
  
  let placeholderLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .darkGray
    return label
  }()
  
  //MARK: - Lifecycle
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    backgroundColor = .white
    font = UIFont.systemFont(ofSize: 16)
    isScrollEnabled = false
    //scroll비활성화 -> 스크롤바 X
    heightAnchor.constraint(equalToConstant: 300).isActive = true
    //텍스트 뷰의 높이를 300 포인트로 고정하는 제약 조건
    //view.을 안해주는 이유는 이미 UITextView가 UIview의 subclass이기 때문이다.
    addSubview(placeholderLabel)
    placeholderLabel.anchor(top: topAnchor, left: leftAnchor,paddingTop: 8, paddingLeft: 4)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
