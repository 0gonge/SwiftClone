//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/6/24.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action:#selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        logUserOut()
        view.backgroundColor = .twitterBlue //화면 전환될 때 조금 더 cleaner하게 보일 수 있도록- 
        authenticateUserAndCongigureUI()
    }
    
    //MARK: - API
  //tabBarController에 해주는게 좋음. 왜냐하면 탭바 움직일 때마다 사용자 정보 반영.fetch를 tabBar에서 해주면 편함.
  func fetchUser(){
    UserService.shared.fetchUser()
  }
    //로그인 된 유저가 로그인을 유지하면서 어플을 이용할 수 있도록 하기 위해 구현
    func authenticateUserAndCongigureUI(){
        if Auth.auth().currentUser == nil {
            //main thread에서 구현이 되어야 함/ 비동기적으로
            DispatchQueue.main.async{
                let nav = UINavigationController(rootViewController: LoginController())
                //로그인에 네비게이션 컨트롤러 내장이 되어있기 때문에 이렇게 해주어야 한다.
                //만약 로그인 컨트롤러만 선언해주게 되면, 로그인 화면에서 가입 화면으로 전환할 수 없다.
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        else {
            configureViewControllers()
            configureUI()
            //사용자가 로그인 할 때까지 / 로그인 하면 mainTabController가 보일 수 있도록
          fetchUser()
          //로그인 후 패치 해주어야 하니까 여기에.
        }
    }
    //로그아웃 구현
    func logUserOut(){
        do{
            try Auth.auth().signOut()
        } catch let error{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    //MARK: - Selectors
    @objc func actionButtonTapped(){
        print("123")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        view.addSubview(actionButton) //safeArea는 기종이 다를때에도 대응해줌. 
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2 //그러면 원이 될 것임 넓이 높이 나누기 2
        let apperearance = UITabBarAppearance()
//        apperearance.configureWithOpaqueBackground()
//        apperearance.backgroundColor = .white
        self.tabBar.standardAppearance = apperearance
        self.tabBar.scrollEdgeAppearance = apperearance
    }
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
        //        self.setViewControllers(viewControllers, animated: true)
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
//        nav.navigationBar.isTranslucent = false
//        nav.navigationBar.barTintColor = .white
        
        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .white
//        appearance.shadowColor = .gray //이렇게 해주니까 아래에 segment효과를 줄 수 있었다
        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        
        return nav
    }
    //재사용성 굳~!~!~!~!
}
