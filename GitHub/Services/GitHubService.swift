//
//  GitHubService.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import Foundation

final class GitHubService {
    static let shared = GitHubService()
    private init(){}
    
    func fetchFollowers(username: String, completion:   @escaping (Result<[Follower], GitHubError>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)/followers"

                guard let url = URL(string: urlString) else {
                    completion(.failure(.invalidUser))
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        completion(.failure(.network))
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.invalidResponse))
                        return
                    }

                    guard let data else {
                        completion(.failure(.invalidData))
                        return
                    }

                    do {
                        let followers = try JSONDecoder().decode([Follower].self, from: data)
                        completion(.success(followers))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }.resume()
    }
    
    func fetchUser(username: String,
                   completion: @escaping (Result<GitHubUser, GitHubError>) -> Void) {

            let urlString = "https://api.github.com/users/\(username)"

            guard let url = URL(string: urlString) else {
                completion(.failure(.invalidUser))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in

                if error != nil {
                    completion(.failure(.network))
                    return
                }

                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }

                guard let data else {
                    completion(.failure(.invalidData))
                    return
                }

                do {
                    let user = try JSONDecoder().decode(GitHubUser.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(.invalidData))
                }
            }.resume()
        }
}

enum GitHubError: Error {
    case invalidUser
    case invalidResponse
    case invalidData
    case network
}
