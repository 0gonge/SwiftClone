//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by 송여경 on 7/2/24.
//

import UIKit

class UploadTweetController: UIViewController {
  //MARK: - Properties
  private let user: User
  
  private lazy var actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .twitterBlue
    button.setTitle("Tweet", for: .normal)
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.white, for: .normal)
    
    button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
    button.layer.cornerRadius = 32 / 2
    
    button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
    return button
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    //비율 유지
    iv.clipsToBounds = true
    //이미지가 UIImageView의 경계를 벗어나지 않도록 클리핑(잘라내기)
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
    return iv
  }()
  //MARK: - Lifecycle
  init(user: User){
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    print("DEBUG: User is \(user.username)")
  }
  //MARK: - Selectors
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
    //화면에 표시되고 있는 뷰 컨트롤러를 해제(dismiss)하여 이전 화면으로 돌아가는 기능을 수행해줌.
  }
  @objc func handleUploadTweet(){
    print("DEBUG: Upload Tweets")
  }
  
  //MARK: - API
  //다른 API를 가져오는 것은 비효율 적. 이미 maintabcontroller에 패칭되어있음.
  
  
  //MARK: - Helpers
  
  func configureUI(){
    view.backgroundColor = .white
    configureNavigationBar()
    
    view.addSubview(profileImageView)
    profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
    
    profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    
  }
  func configureNavigationBar(){
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.white
    
    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    self.navigationController?.navigationBar.standardAppearance = appearance
    //ios업데이트 하면서 바뀜..
    navigationController?.navigationBar.isTranslucent = false
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
  }
}
