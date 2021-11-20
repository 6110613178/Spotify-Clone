//
//  Library.swift
//  SpotifyClone
//
//  Created by Ahmet Alkan on 21.11.2020.
//

import SwiftUI


//While creating the Library struct of the Spotify clone, https://medium.com/swlh/building-spotifys-ui-with-swiftui-5f8be5c2bdd4 was used.

struct Library: View {

    var subCategorys : [String]
    @State var currentSubCategoryIndex : Int = 0
    @State var indicatorOffset : CGFloat = 0
    var body: some View {
        HStack{
            subCategory(index: 0, parent: self)
            Spacer()
        }
        
    }
    
    struct subCategory: View{
        var index: Int
        var parent: Library
        var body: some View{
            VStack{
                Text(parent.subCategorys[index])
                    .font(.headline)
                    .foregroundColor(parent.currentSubCategoryIndex == index ? .white : .secondary)
                    .onTapGesture {
                        withAnimation(.easeIn,{
                            self.parent.currentSubCategoryIndex = self.index
                        })
                    }
                Rectangle()
                    .frame(height: 2)
                    .offset(x: parent.indicatorOffset)
                    .foregroundColor(parent.currentSubCategoryIndex == index ? .green : .clear)
                    .animation(.none)
            }.fixedSize().padding(.leading)
        }
    }
}

struct LibraryPage : View {
    
    @ObservedObject var viewModel = PlaylistViewModel()
    
//    var songs: [String:String] = ["penthouse":"Penthouse" , "Anadolu_Rock":"Anadolu Rock","cemKaraca":"Cem Karaca","Türkce_90lar":"Türkçe 90'lar"]
    @State var CategoryIndex : Int
    @State var subCategorys = ["Playlists"]
    @State var page = "music"

    var body: some View{
        ZStack{
            Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all)

            VStack{
                HStack(spacing: 20){
                    Text("Music")
                        .font(.largeTitle).bold()
                        .foregroundColor(self.CategoryIndex == 0 ? .white : .secondary)
                        .onTapGesture {
                            page = "music"
                            withAnimation(.easeIn,{
                                subCategorys = ["Playlists"]
                                self.CategoryIndex = 0
                            })
                        }
                        .padding(.top,-60)
                    Spacer()
                }.padding([.leading, .top])
                Library(subCategorys: subCategorys).padding(.top)
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    VStack(spacing: 15){

//                        ForEach(searchQuery == "" ? songs.keys.sorted() :
//                                    songs.keys.sorted().filter{$0.lowercased().contains(searchQuery.lowercased())} , id: \.self
//                        ) { song in
//                            MusicSearchList(image: songs[song]!, songName: song)
//                        }
                        ForEach(viewModel.filterPlaylistMusics()) { music in
                            MusicList(music: music)
                        }
                        
                    }
                }).padding(.top, 10)
            }
            
        }
    }
    
}
struct Library_Previews: PreviewProvider {

    static var previews: some View {
        LibraryPage(CategoryIndex: 0)
        //Playlist(image: "cemKaraca", songName: "sdsad", presentPage: "podcast")
    }
}
