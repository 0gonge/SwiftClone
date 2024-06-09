//
//  ConversationsController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/6/24.
//

import UIKit

class ConversationsController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
