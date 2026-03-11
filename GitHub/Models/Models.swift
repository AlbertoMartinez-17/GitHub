//
//  Models.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import Foundation

struct Follower: Decodable, Identifiable {
    let login: String
    let avatar_url: String
    
    var id: String { login }
}

struct FavoriteUser: Codable, Equatable, Identifiable {
    let username: String
    let avatarURL: String
    
    var id: String { username }
}

struct GitHubUser: Decodable {
    let login: String
    let avatar_url: String
}
