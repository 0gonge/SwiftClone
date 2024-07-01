//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by 송여경 on 7/2/24.
//

import UIKit

class UploadTweetController: UIViewController {
  //MARK: - Properties
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
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
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
  
  //MARK: - Helpers
  
  func configureUI(){
    view.backgroundColor = .white
    
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
