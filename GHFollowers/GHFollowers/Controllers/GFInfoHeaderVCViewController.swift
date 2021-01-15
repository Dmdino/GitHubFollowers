//
//  GFInfoHeaderVCViewController.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 23.06.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class GFInfoHeaderVCViewController: UIViewController {
    
    // MARK: - Properties
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let usernameLabel = CustomTitleLabel(textAligment: .left, fontSize: 34)
    let nameLabel = GFSecondaryLabel(fontSize: 18)
    let locationImageView = UIImageView()
    var locationLabel = GFSecondaryLabel(fontSize: 18)
    let bioLabel = CustomBodyTitleLabel(textAligment: .left)
    
    var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
        
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user?.avatarUrl ?? "")
        usernameLabel.text = user?.login
        nameLabel.text = user?.name ?? ""
        locationLabel.text = user?.location ?? "No Location"
        bioLabel.text = user?.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        avatarImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: padding, left: padding, bottom: 0, right: 0), size: .init(width: 90, height: 90))
        
        usernameLabel.anchor(top: avatarImageView.topAnchor, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: padding), size: .init(width: 0, height: 38))
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
        nameLabel.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: padding), size: .init(width: 0, height: 20))
        
        locationImageView.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: avatarImageView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.anchor(top: nil, leading: locationImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: padding), size: .init(width: 0, height: 20))
        
        bioLabel.anchor(top: avatarImageView.bottomAnchor, leading: avatarImageView.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: textImagePadding, left: 0, bottom: 0, right: padding), size: CGSize.init(width: 0, height: 60))
    }
}
