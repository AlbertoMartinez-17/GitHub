//
//  FavoritesViewModel.swift
//  GitHub
//
//  Created by alberto on 10/03/26.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteUser] = []
    
    init() {
        getFavs()
    }
    
    func getFavs() {
        favorites = FavoritesManager.shared.getFavorites()
    }
}
