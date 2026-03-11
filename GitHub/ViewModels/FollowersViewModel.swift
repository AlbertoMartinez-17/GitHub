//
//  FollowersViewModel.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import Foundation

class FollowersViewModel: ObservableObject {
    @Published var followers: [Follower] = []
    @Published var user: GitHubUser?
    
    func fetchFollowers(username: String) {
        let urlString = "https://api.github.com/users/\(username)/followers"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let decoded = try? JSONDecoder().decode([Follower].self, from: data)
                DispatchQueue.main.async {
                    self.followers = decoded ?? []
                }
            }
        }.resume()
    }
    
    func fetchUser(username: String) {
        let urlString = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let decoded = try? JSONDecoder().decode(GitHubUser.self, from: data)
                DispatchQueue.main.async {
                    self.user = decoded
                }
            }
        }.resume()
    }
}
