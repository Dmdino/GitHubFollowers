//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 05.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "FolowwersCell"
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let usernameLabel = CustomTitleLabel(textAligment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .systemBlue
        configure()
    }
    
    func setFollower(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        avatarImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        usernameLabel.anchor(top: avatarImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 12, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 20))
        usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
