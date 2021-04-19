//
//  Post.swift
//  SocialKit
//
//  Created by Rubens Ferreira Ramos on 18/04/21.
//

import Foundation

// MARK: - Post
// MARK: - Post
struct Post: Codable, Identifiable {
    let userId, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id, title, body
    }
}
