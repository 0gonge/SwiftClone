//
//  FeedController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/6/24.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
  //MARK: - Properties
  
  var user: User?{
    didSet{
      configureLeftBarButton()
    } //user있을 경우 동작함.
  }
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  //MARK: - Helpers
  func configureUI(){
    view.backgroundColor = .white
    
    let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    imageView.contentMode = .scaleAspectFit
    navigationItem.titleView = imageView
    
  }
  func configureLeftBarButton(){
    guard let user = user else { return } //user가 존재함을 보장.
    let profileImageView = UIImageView()
    profileImageView.setDimensions(width: 32, height: 32)
    profileImageView.layer.cornerRadius = 32 / 2
    profileImageView.layer.masksToBounds = true
    //cornerRadius를 사용하여 이미지의 모서리를 둥글게 할 때, masksToBounds를 true로 설정하지 않으면 모서리가 둥글게 잘리지 않는다. 클리핑을 해주어야 한다.
    //보통 프로필 이미지를 둥글게 만들기 위해 cornerRadius와 masksToBounds를 함께 사용.
    
    profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    //completed: nil은 이미지 다운로드가 완료된 후 추가적으로 실행할 코드가 없다는 것을 의미한다. 즉, 이미지를 설정하는 것만 필요하고, 완료 후 특별히 처리할 작업이 없기 때문에 콜백 함수를 지정하지 않은 것!
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
  }
}
