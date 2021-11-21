//
//  HomePage.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 18/11/2564 BE.
//

import SwiftUI

struct HomePage:View {
    
    @State var refresh: Bool = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
      }

    var body: some View {
        NavigationView{
            TabView{
                ContentPage()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                SearchPage()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                LibraryPage(CategoryIndex: 0)
                    .tabItem {
                        Image("library")
                        Text("Library")
                    }
                    .onTapGesture {
                        update()
                    }
            }
            .navigationBarItems(trailing: logOutButton)
            .accentColor(.white)
        }
    }
    
    func update() {
        refresh.toggle()
    }
    
    var logOutButton: some View{
        Button{
            AuthViewModel.share.signOut()
        } label:{
            Text("Log Out")
                .foregroundColor(.white)
        }
    }
}


struct HomeP_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
