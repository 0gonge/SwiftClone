//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/6/24.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
    }
    
    //MARK: - Helpers
    func configureViewControllers(){ //programatically하게 다른 모든 컨트롤러를 구현해줄 곳이다.
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationsController()
        let conversations = ConversationsController()
        
        viewControllers = [feed, explore, notifications, conversations]
        //필요한 보기 컨트롤러 속성들을 array로 정의를 해주었다.
        //UITabBarController의 sub나 subclass로 가져올 것.
        //
    }
}
