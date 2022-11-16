//
//  User.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation

struct User: Codable {
    let userId: Int
    let albumId: Int
    let name: String
    let url: String
    let thumbnailUrl: String
    var posts: Array<Post>?
}
