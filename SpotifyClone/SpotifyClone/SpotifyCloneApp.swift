//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 18/11/2564 BE.
//

import SwiftUI
import Firebase

@main
struct SpotifyCloneApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.share)
            //Homepage()
        }
    }
}
