//
//  SearchViewModel.swift
//  SpotifyClone
//
//  Created by Teerat Prasitwet on 20/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class SearchViewModel: ObservableObject {
    @Published var musics = [Music]()
    
    init(){
        fetchSearchMusics()
    }
    
    func fetchSearchMusics(){
        Firestore.firestore().collection("musics").getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.musics = documents.compactMap { try? $0.data(as: Music.self)}
        }
    }
    
    func filterSearchMusics(withText input: String) -> [Music] {
        let lowercasedInput = input.lowercased()
        return musics.filter{ $0.nameMusic.lowercased().contains(lowercasedInput) || $0.ownerMusic.lowercased().contains(lowercasedInput)}
    }
}
