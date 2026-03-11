//
//  FavoritesView.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.favorites) { favorite in
                NavigationLink(
                    destination: FollowersView(username: favorite.username)
                ) {
                    HStack {
                        AsyncImage(url: URL(string: favorite.avatarURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        
                        Text(favorite.username)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.getFavs()
            }
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
