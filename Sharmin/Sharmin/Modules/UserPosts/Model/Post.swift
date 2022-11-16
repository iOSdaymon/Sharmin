//
//  Post.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
