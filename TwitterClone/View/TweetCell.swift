//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 송여경 on 7/4/24.
//

import UIKit

class TweetCell: UICollectionViewCell {
  
  override init(frame: CGRect){
    super.init(frame: frame)
    
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder){
    fatalError("init(corder: has not been implemented")
  }
}
