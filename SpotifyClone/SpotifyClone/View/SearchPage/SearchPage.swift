//
//  SearchPage.swift
//  SpotifyClone
//
//  Created by AlkanBurak on 26.10.2020.
//

import SwiftUI

struct Category: View {
    var color1: Color
    var text1: String
    var color2: Color
    var text2: String

    var body: some View{
        ZStack{
            HStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(color1)
                        .frame(height:103)
                        .cornerRadius(5)
                        .padding()
                        
                   VStack{
                    HStack{
                        Text(text1).foregroundColor(.white)
                            .fontWeight(.bold).font(.title3)
                        Spacer()
                    }.padding(.leading, 27.0).padding(.top, 12.0)
                    
                    Spacer()

                   }.frame(height:103)

                }
                
                ZStack{
                    Rectangle()
                        .foregroundColor(color2)
                        .frame(height:103)
                        .cornerRadius(5)
                        .padding()
                   VStack{
                    HStack{
                        Text(text2).foregroundColor(.white)
                            .fontWeight(.bold).font(.title3)
                        Spacer()
                    }.padding(.leading, 27.0).padding(.top, 12.0)
                    
                    Spacer()

                   }.frame(height:103)
                }
            }
        }
    }
}

struct SearchPage: View {
    @State private var isSearchPageOpen = false
    let categories = ["Podcast":"Listeler","Hip Hop":"Chill","Fitness":"Romantic"]
    var body: some View {
        ZStack{
            Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Search").font(.largeTitle).foregroundColor(.white).bold()
                    Spacer()
                }
                .padding(.top,-45)
                .padding(.leading,10)
                
                Button(action: {}, label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 382, height: 43.5)
                                .cornerRadius(7)
                                .onTapGesture( perform: {
                                self.isSearchPageOpen.toggle()
                                }).fullScreenCover(isPresented: $isSearchPageOpen, content: {
                                    Search()
                                })
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                                    .font(.system(size: 25))
                                Text("Artist, songs, or podcast").foregroundColor(.black).padding(.leading, 5)
                                Spacer()
                            }.offset(x: 25)
                    }
                })
                ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                        Text("Your top genres")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding([.top , .trailing , .leading])
                    Category(color1: .blue,text1: "Pop" ,color2: .secondary, text2: "Rock")
                    Category(color1: .red,text1: "Jass" ,color2: .green, text2: "Folk and Acoustic")
                }
                    HStack{
                        Text("Browse all")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding()
                    ForEach(categories.keys.sorted(), id: \.self) { cat in
                        Category(color1: .red, text1: cat, color2: .blue, text2: categories[cat]!)
                    }
                    
                }
            }
            
            
        }
    }
}
struct Search: View {
    @Environment(\.presentationMode) var presentationMode
//
//no problem if array empty
    var songs: [String:String] = ["The Everlasting":"The Everlasting [Img]", "Say So [JP ver.]":"Say So [JP ver.] [Img]", "Departures":"Departures [Img]"]
    @State var searchQuery = ""

    init() {
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9249785959)
        UITextField.appearance().backgroundColor = #colorLiteral(red: 0.1411563158, green: 0.1411880553, blue: 0.1411542892, alpha: 1)
        UITextField.appearance().textColor = .white
    }
    
//    @State private var src = ""
    var body: some View{
        NavigationView{
            ZStack{
                Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9545430223)).edgesIgnoringSafeArea(.all)
                    
                    .navigationBarItems(trailing:
                                            HStack{
//
                                                TextField("Search", text: $searchQuery)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .frame(width: UIScreen.main.bounds.width - 150).accentColor(.green)
                                                Button(action: {
                                                    presentationMode.wrappedValue.dismiss()
                                                }, label: {
                                                    Text("Cancel")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.medium)
                                                }).padding(.trailing)
                                                Button(action: {}, label: {
                                                    Image(systemName: "camera")
                                                        .foregroundColor(.white)
                                                })}
                    )
                    .navigationBarTitleDisplayMode(.inline)
//
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    VStack(spacing: 15){

                        ForEach(searchQuery == "" ? songs.keys.sorted() :
                                    songs.keys.sorted().filter{$0.lowercased().contains(searchQuery.lowercased())} , id: \.self
                        ) { song in
                            MusicSearchList(image: songs[song]!, songName: song)
                        }
                    }
                }).padding(.top, 10)
            }
            
        }
    }
}
//
struct MusicSearchList: View {
    
    @State private var isPlayerOpen = false
    var image: String
    var songName : String
    
    var body: some View{
        
        HStack{
            Image(image).resizable()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading){
                Text(songName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("by Spotify")
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
            Player(songName: songName, albumImage: image)
        })
        
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}

