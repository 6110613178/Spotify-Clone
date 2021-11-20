//
//  MusicList.swift
//  SpotifyClone
//
//  Created by Teerat Prasitwet on 19/11/2564 BE.
//

import SwiftUI

struct MusicCard: View {  // ContentPage bottom
     
    @State var music: Music
    
    @State private var isPlayerOpen = false
    
    var body: some View{
        VStack(alignment: .leading){
            Image(music.musicImage)
                .resizable()
                .frame(width: 124, height: 124)
            Text(music.nameMusic)
                .foregroundColor(.white).fontWeight(.medium).font(.system(size: 15))
        }.onTapGesture {
            isPlayerOpen.toggle()
        }
        .fullScreenCover(isPresented: $isPlayerOpen, content: {
            Player(songName: music.nameMusic, albumImage: music.musicImage, music: music)
        })
    }
}

