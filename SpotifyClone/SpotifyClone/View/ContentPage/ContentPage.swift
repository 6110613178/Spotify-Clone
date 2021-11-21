//
//  ContentPage.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 18/11/2564 BE.
//

import SwiftUI

struct ContentPage: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.barTintColor = .clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @ObservedObject var viewModel = MusicsViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient.init(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.7745838351, alpha: 0.5)), .black , .black, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                        Text("Good Morning").font(.title).foregroundColor(.white).bold()
                        Spacer()
                    }.padding(.top,65)
                    
                    HStack{
                        VStack{
                            ForEach(viewModel.musics) { music in
                                MusicTop(music: music).padding(.trailing, 7)
                                
                            }
                            
                        }
                        VStack{
                            ForEach(viewModel.musics) { music in
                                MusicTop(music: music).padding(.trailing, 7)
                                
                            }
                        }
                    }.padding().frame(width: UIScreen.main.bounds.width)
                    VStack(alignment: .leading){
                        HStack{
                            Text("Recently played").font(.title2).foregroundColor(.white).bold()
                            Spacer()
                        }.padding()
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(viewModel.musics) { music in
                                    MusicCard(music: music).padding(.trailing, 7)
                                    
                                }
                                ForEach(viewModel.musics) { music in
                                    MusicCard(music: music).padding(.trailing, 7)
                                    
                                }
                            }
                            .padding(.leading)
                        }
                    }.frame(width: UIScreen.main.bounds.width)
                    VStack{
                        HStack {
                            //
                            Image("Egoist")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                            VStack(alignment:.leading) {
                                Text("FOR FANS OF")
                                    .fontWeight(.ultraLight)
                                    .font(.system(size: 15))
                                    .foregroundColor(.init(.white))
                                    .opacity(0.8).offset(x: 1, y: 3)
                                Text("Egoist")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            Spacer()
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                //
                                ForEach(viewModel.musics) { music in
                                    MusicCard(music: music).padding(.trailing, 7)
                                    
                                }
                            }
                        }
                    }.padding(.top, 20).padding()
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

struct ContentPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentPage()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
