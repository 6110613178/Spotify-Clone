//
//  MusicList.swift
//  SpotifyClone
//
//  Created by Teerat Prasitwet on 19/11/2564 BE.
//

import SwiftUI

struct MusicList: View {
    
    @State var music: Music
    
    @State private var isPlayerOpen = false
    
    var body: some View{
        
        HStack{
            Image(music.musicImage).resizable()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading){
                Text(music.nameMusic)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(music.ownerMusic)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding([.leading])
        .onTapGesture {
            isPlayerOpen.toggle()
        }
        .fullScreenCover(isPresented: $isPlayerOpen, content: {
            Player(songName: music.nameMusic, albumImage: music.musicImage)
        })
        
    }
}

