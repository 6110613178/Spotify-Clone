//
//  MusicTop.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 21/11/2564 BE.
//

import SwiftUI

struct MusicTop: View {  // ContentPage Top
     
    @State var music: Music
    
    @State private var isPlayerOpen = false
    
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(.init(#colorLiteral(red: 0.1686044633, green: 0.1686406434, blue: 0.1686021686, alpha: 1)))
                .opacity(0.8)
                .frame(width: 187, height: 56)
                .cornerRadius(5)
            
            HStack{
                Image(music.musicImage).resizable()
                    .frame(width: 56, height: 56)
                    .cornerRadius(4, corners: [.topLeft, .bottomLeft])
                //.offset(x: -66, y: 0)
                Spacer()
                Text(music.nameMusic)
                    .foregroundColor(.white).fontWeight(.semibold).font(.system(size: 15))
                Spacer()
                Spacer()
                Spacer()
            }.frame(maxWidth:187 ,  maxHeight: 56)
                .onTapGesture {
                    isPlayerOpen.toggle()
                }
                .fullScreenCover(isPresented: $isPlayerOpen, content: {
                    Player(songName: music.nameMusic, albumImage: music.musicImage, music: music)
                })
        }
    }
}
