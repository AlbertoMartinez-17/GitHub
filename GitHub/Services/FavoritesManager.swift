//
//  FavoritesManager.swift
//  GitHub
//
//  Created by alberto on 10/03/26.
//

import Foundation

final class FavoritesManager {
    
    static let shared = FavoritesManager()
    private let key = "favoriteUser"
    
    private init() {}
    
    func getFavorites() -> [FavoriteUser] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        return (try? JSONDecoder().decode([FavoriteUser].self, from: data)) ?? []
    }
    
    func save(_ favorites: [FavoriteUser]) {
        let data = try? JSONEncoder().encode(favorites)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func add(_ favorite: FavoriteUser) -> Bool {
        var favorites = getFavorites()

        guard !favorites.contains(favorite) else { return false }

        favorites.append(favorite)
        save(favorites)
        return true
    }
        
    func remove(_ favorite: FavoriteUser) {
        var favorites = getFavorites()
        favorites.removeAll {
            $0.username == favorite.username
        }
        save(favorites)
    }
    
    func isFavorite(_ username: String) -> Bool {
        let favorites = getFavorites()
        return favorites.contains { $0.username == username }
    }
    
}
