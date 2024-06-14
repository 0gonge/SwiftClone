//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by 송여경 on 6/14/24.
//

import UIKit

class RegistrationController: UIViewController{
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .twitterBlue
    }
}
