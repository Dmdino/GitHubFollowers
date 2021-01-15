//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 04.01.2021.
//  Copyright © 2021 Дмитрий Папушин. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let usernameLabel = CustomTitleLabel(textAligment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        avatarImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: padding, bottom: 0, right: 0), size: .init(width: 60, height: 60))
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        usernameLabel.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: padding), size: .init(width: 0, height: 40))
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
