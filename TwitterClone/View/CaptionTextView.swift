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
    label.text = "What's happening?"
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
    placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Selectors
  @objc func handleTextInputChange(){
    placeholderLabel.isHidden = !text.isEmpty
    //if문과 비슷한 역할을 해 준다. Empty가 아닐때, 그러니까 무언가 써져있을 때 placeholderLabel을 숨겨준다.
    //Empty가 true면 ! 하면 false / hidden 하지 않는다. 직관적 이해 완.
    //if text.isEmpty {
    //    placeholderLabel.isHidden = false
    //  }
    //  else {
    //    placeholderLabel.isHidden = true
    //  }
  }
}
