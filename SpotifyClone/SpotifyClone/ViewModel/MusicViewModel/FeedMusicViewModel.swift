//
//  FeedMusicViewModel.swift
//  SpotifyClone
//
//  Created by Teerat Prasitwet on 19/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class FeedMusicViewModel: ObservableObject {
    @Published var musics = [Music]()
    
    init(){
        fetchPosts()
    }
    
    func fetchPosts(){
        Firestore.firestore().collection("musics").getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.musics = documents.compactMap { try? $0.data(as: Music.self)}
        }
    }
}
