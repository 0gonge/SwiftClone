//
//  UserCell.swift
//  TwitterClone
//
//  Created by 송여경 on 12/8/24.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
