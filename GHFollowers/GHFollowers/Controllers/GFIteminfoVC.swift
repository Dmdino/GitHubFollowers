//
//  GFIteminfoVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.08.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

protocol ItemInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class GFIteminfoVC: UIViewController {
    
    let itemInfoOne = GFItemInfoView()
    let itemInfoTwo = GFItemInfoView()
    @objc let actionButton = CustomButton()
    
    var user: User?
    weak var delegate: ItemInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureBackgroundView()
        layoutUI()
        configureActionButton()
    }

    
    func confugureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    fileprivate func layoutUI() {
        
        let stackView = UIStackView(arrangedSubviews: [itemInfoOne, itemInfoTwo])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        view.addSubview(actionButton)

        let padding: CGFloat = 20
        
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 50))
        
        actionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
    }
    
}
