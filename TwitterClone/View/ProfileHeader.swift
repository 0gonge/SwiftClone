//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by 송여경 on 8/19/24.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
  //MARK: - Properties
  
  //MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
