//
//  Music.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 19/11/2564 BE.
//


import Firebase
import FirebaseFirestoreSwift

struct Music: Decodable, Identifiable {
    
    @DocumentID var id: String?
    var didLike: Bool? = false
    var didInPlaylist: Bool? = false
    var isTopSong: Bool
    var musicImage: String
    var nameMusic: String
    var ownerMusic: String
}
