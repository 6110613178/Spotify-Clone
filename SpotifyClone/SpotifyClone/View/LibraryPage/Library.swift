//
//  Library.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 18/11/2564 BE.
//

import SwiftUI


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
    
    @ObservedObject var viewModel = MusicsViewModel()
    
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

                        ForEach(viewModel.musics) { music in
                            MusicPlaylist(viewModel: CellMusicViewModel(music: music) ,music: music)
                        }
                        
                    }
                }).padding(.top, 10)
            }
            
        }
        
    }
    
}
