//
//  FollowersView.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import SwiftUI

struct FollowersView: View {
    var username: String
    @StateObject private var viewModel = FollowersViewModel()
    @State private var isFavorite = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.followers) { follower in
                    VStack {
                        AsyncImage (url: URL(string: follower.avatar_url)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
                        
                        Text(follower.login)
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(username)
        .onAppear {
            viewModel.fetchFollowers(username: username)
            viewModel.fetchUser(username: username)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    guard let favUser = viewModel.user else { return }
                    let favorite = FavoriteUser(username: favUser.login, avatarURL: favUser.avatar_url)
                    isFavorite = FavoritesManager.shared.add(favorite)
//                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
            }
        }
    }
}

//struct FollowersView_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowersView(username: "albertomartinez-17")
//    }
//}
//
