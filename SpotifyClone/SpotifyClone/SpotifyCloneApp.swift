//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by AlkanBurak on 25.10.2020.
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
