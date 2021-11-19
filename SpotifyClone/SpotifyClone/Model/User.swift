//
//  User.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 19/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Decodable, Identifiable {
    
    @DocumentID var id: String?
    let username: String
    let email: String
    var addPlayList: Bool? = false
    
    var isCurrentUser: Bool {
        AuthViewModel.share.userSession?.uid == id
    }
}
