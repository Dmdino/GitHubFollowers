//
//  Follower.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 05.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
