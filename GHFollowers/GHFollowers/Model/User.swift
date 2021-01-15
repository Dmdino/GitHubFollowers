//
//  User.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 05.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    let location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
