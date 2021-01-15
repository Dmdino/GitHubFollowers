//
//  GFReapoItemVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.08.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class GFReapoItemVC: GFIteminfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .repos, withCount: user?.publicRepos ?? 0)
        itemInfoTwo.set(itemInfoType: .gists, withCount: user?.publicGists ?? 0)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user!)
    }
    
}
