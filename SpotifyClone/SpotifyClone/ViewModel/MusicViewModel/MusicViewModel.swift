//
//  MusicViewModel.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 19/11/2564 BE.
//

import SwiftUI
import Firebase

class MusicViewModel: ObservableObject {
    @Published var music: Music
    
    init(music: Music) {
        self.music = music
        checkLike()
    }
    
    func like() {
        if let didLike = music.didLike, didLike {
            return
        }
        guard let musicID = music.id else { return }
        guard let userID = AuthViewModel.share.userSession?.uid else { return }
                
        Firestore.firestore().collection("musics").document(musicID).collection("music-likes")
            .document(userID).setData([:]){ error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            Firestore.firestore().collection("users").document(userID).collection("user-likes")
                .document(musicID).setData([:]){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.music.didLike = true
            }
        }
    }
    
    func checkLike(){
        guard let musicID = music.id else { return }
        guard let userID = AuthViewModel.share.userSession?.uid else { return }
        
        Firestore.firestore().collection("musics").document(musicID).collection("music-likes")
            .document(userID).getDocument{ (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let didLike = snap?.exists else { return }
            self.music.didLike = didLike
        }
    }
    
    func unlike() {
        if let didLike = music.didLike, !didLike {
            return
        }
        guard let musicID = music.id else { return }
        guard let userID = AuthViewModel.share.userSession?.uid else { return }
                
        Firestore.firestore().collection("musics").document(musicID).collection("music-likes")
            .document(userID).delete(){ error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            Firestore.firestore().collection("users").document(userID).collection("user-likes")
                .document(musicID).setData([:]){ error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.music.didLike = false
            }
        }
    }
}
