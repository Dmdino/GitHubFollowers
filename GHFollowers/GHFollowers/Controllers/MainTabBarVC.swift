//
//  MainTabBarVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 24.04.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.delegate = self

        UITabBar.appearance().tintColor = .systemGreen
        
        let searchVC = createNavcontroller(viewController: SearchVC(), title: "Feed", uiTabBarItem: UITabBarItem(tabBarSystemItem: .search, tag: 0))
        let favoritiesVC = createNavcontroller(viewController: FavoritesListVC(), title: "Favorities", uiTabBarItem: UITabBarItem(tabBarSystemItem: .favorites, tag: 1))
        
        viewControllers = [searchVC, favoritiesVC]
    }
    
    func createNavcontroller(viewController: UIViewController, title: String, uiTabBarItem: UITabBarItem) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        navController.tabBarItem = uiTabBarItem
        
        return navController
    }

}

