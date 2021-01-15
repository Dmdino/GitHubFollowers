//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 21.07.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolimageView = UIImageView()
    let titleLabel = CustomTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = CustomTitleLabel(textAligment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolimageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        //symbolimageView.translatesAutoresizingMaskIntoConstraints = false
        symbolimageView.contentMode = .scaleAspectFill
        symbolimageView.tintColor = .label
        
        symbolimageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 20, height: 20))
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolimageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolimageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolimageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolimageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolimageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolimageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolimageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}
