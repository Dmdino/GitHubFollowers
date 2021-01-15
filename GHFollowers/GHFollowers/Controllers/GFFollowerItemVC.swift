//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.08.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFIteminfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .followers, withCount: user?.followers ?? 0)
        itemInfoTwo.set(itemInfoType: .following, withCount: user?.following ?? 0)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user!)
    }
    
}
