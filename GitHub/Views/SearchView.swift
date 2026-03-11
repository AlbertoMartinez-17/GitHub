//
//  SearchView.swift
//  GitHub
//
//  Created by alberto on 09/03/26.
//

import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    @State private var goNext = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack (spacing: 32){
                    Image("ghFollowers")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    TextField("Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Get Followers") {
                        goNext = true
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(12)
                    .disabled(username.isEmpty)
                    
                }
                .padding(24)
                .navigationDestination(isPresented: $goNext) {
                    FollowersView(username: username)
                }
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
