//
//  Player.swift
//  SpotifyClone
//
//  Created by AlkanBurak on 18.11.2020.
//

import SwiftUI
import AVKit

struct Player: View {
    @Environment(\.presentationMode) var presentationMode
    @State var shuffle = false
    @State var repeatButton = true
    @State var play = true
    @State var time: Double = 50
    @State var like = false
    @State var devices = true
    @State var blur = false

    @State var data: Data = .init(count: 0)
    @State var title = ""
    @State var artist = ""
    @State var player : AVAudioPlayer!
    @State var playing = false
    @State var width : CGFloat = 0
    @State var songs = ["The Everlasting", "Say So [JP ver.]", "Departures"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()
    @State var timeLeft = "0:00"
    @State var timeRight = ""

    var albumImage : String
    var songName : String
    var colors : [Color : Color] = [Color.init(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)):Color.gray , Color.init(#colorLiteral(red: 0.5325785279, green: 0.3929539323, blue: 0.2947138846, alpha: 1)):Color.init(#colorLiteral(red: 0.2959476709, green: 0.2161997557, blue: 0.1564876735, alpha: 1)),Color.init(#colorLiteral(red: 0.6307879686, green: 0.04571723193, blue: 0.1284509301, alpha: 1)):Color.init(#colorLiteral(red: 0.3453397155, green: 0.03347708657, blue: 0.07076438516, alpha: 1)),Color.init(#colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)):Color.init(#colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1))]
    var backgroundColor : Color
    var backgroundColor2 : Color
    
    init(songName : String, albumImage : String){
        self.songName = songName
        self.albumImage = albumImage
        backgroundColor = colors.randomElement()!.key
        backgroundColor2 = colors[backgroundColor]!
    }
    
    var body: some View {
        ZStack{
            LinearGradient.init(gradient: Gradient(colors: [backgroundColor , backgroundColor2]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                        self.player.pause()
                        self.playing = false
                        
                    }, label: {
                        Image(systemName: "chevron.down").font(.body)
                            .foregroundColor(.white)
                    }).frame(width: 60, height: 60)
                    Spacer()
                    Text("\(songName)")
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .frame(width: 60, height: 30)
                        .onTapGesture {
                            withAnimation {
                                blur.toggle()
                            }
                        }
                }
                Spacer()
                
                Image(uiImage: self.data.count == 0 ? UIImage(named: "Spotify")! : UIImage(data: self.data)!)
                    .resizable()
                    .padding([.leading, .trailing], 20)
                    .padding([.top, .bottom], 25)
                
                VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text(self.artist)
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold().padding(.leading , 3)
                        Text(self.artist)
                            .padding([.leading , .top] , 3)
                            .foregroundColor(.white).opacity(0.8)
                            .font(.callout)
                    }
                    Spacer()
                    Button(action: {
                        like.toggle()
                    }, label: {
                        Image(systemName: like ? "heart.fill" : "heart").foregroundColor(like ? .green :.white )
                            .font(.system(size: 20)).animation(.default)
                    })
                }.padding([.leading,.trailing,.top],20)
                    
                    ZStack(alignment: .leading) {
                        
                        Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                        
                        Capsule().fill(Color.white).frame(width: self.width, height: 8)
                            .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            
                                            let x = value.location.x
                                            
                                            self.width = x
                                            
                                        }).onEnded({ (value) in
                                            
                                            let x = value.location.x
                                            
                                            let screen = UIScreen.main.bounds.width - 30
                                            
                                            let percent = x / screen
                                            
                                            self.player.currentTime = Double(percent) * self.player.duration
                                        })
                            )
                    }
                    .padding([.trailing,.leading] , 20)
                    .padding(.bottom, 30)
                    
                    HStack{
                        Text(self.timeLeft).foregroundColor(.white).offset(x: 20, y: -30)
                        Spacer()
                        Text(self.timeRight).foregroundColor(.white).offset(x: -20, y: -30)
                        
                    }
                    
                    HStack{
                        Button(action: {
                            
                            if self.current > 0{
                                
                                self.current -= 1
                                
                                self.ChangeSongs()
                            }
                            else {
                                
                                self.ChangeSongs()
                            }
                            
                        }, label: {
                            Image(systemName: "backward.end.fill").resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.white)
                            
                        })
                        
                        Button(action: {
                            
                            if self.player.isPlaying{
                                
                                self.player.pause()
                                self.playing = false
                            }
                            else{
                                
                                self.player.play()
                                self.playing = true
                            }
                            
                        }, label: {
                            Image(systemName: self.playing && !self.finish ? "pause.circle.fill" : "play.circle.fill").resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .foregroundColor(.white)
                            
                        }).padding([.trailing,.leading], 50)
                        
                        Button(action: {
                            
                            if self.songs.count - 1 != self.current{
                                
                                self.current += 1
                                
                                self.ChangeSongs()
                            }
                            
                        }, label: {
                            Image(systemName: "forward.end.fill").resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.white)
                            
                        })
                    }.padding([.trailing,.leading , .bottom] , 20)
                }
                HStack{
                    Image(systemName: "text.badge.plus").foregroundColor(.white)
                }.padding()
            }.blur(radius: blur ? 30.0 : 0)
            
            .onAppear {
                
                let url = Bundle.main.path(forResource: "\(songName)", ofType: "mp3")
                
                let songIndex = songs.firstIndex(of: "\(songName)")
                let songIndexInt = songIndex!
                
                for _ in 0..<songIndexInt {
                    
                    songs.append(songs[0])
                    songs.remove(at: 0)
                }
                
                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
                
                self.player.delegate = self.del
                
                self.player.prepareToPlay()
                self.getData()
                
                self.findTimeRight(delay: 1)
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    
                    if self.player.isPlaying{
                        
                        self.findTimeLeft()
                        self.findTimeRight(delay: 0)
                        
                        let screen = UIScreen.main.bounds.width - 40
                        
                        let value = self.player.currentTime / self.player.duration
                        
                        self.width = screen * CGFloat(value)
                    }
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                    
                    self.finish = true
                }
            }
            
            if blur {
                blurPage
            }
        }
    }
    var blurPage: some View{
        ZStack{
            Color.clear
            VStack{
                ScrollView(.vertical){
                    VStack{
                        
                        Image(uiImage: self.data.count == 0 ? UIImage(named: "Spotify")! : UIImage(data: self.data)!)
                            .resizable()
                            .frame(width: 160, height: 160)
                            .padding()
                        Text(self.artist)
                            .foregroundColor(.white)
                            .bold()
                        Text(self.title).padding([.top, .bottom] , 3)
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .font(.headline)
                        
                    }.padding(.top , 200)
                    
                    BlurPageButton(image: "heart", text: "Like")
                    //BlurPageButton(image: "moon", text: "Sleep timer")

            }
                Button(action: {
                    withAnimation {
                        blur.toggle()
                    }
                }, label: {
                    ZStack{
                        Rectangle().frame(width: UIScreen.main.bounds.width, height: 40)
                            .foregroundColor(.clear)
                            .blur(radius: 5.0)
                        Text("Close").foregroundColor(.white)
                    }
                })
            }
        }
    }
    
    func getData(){
        
        let asset = AVAsset(url: self.player.url!)
        
        for i in asset.commonMetadata{
            
            if i.commonKey?.rawValue == "artwork" {
                
                let data = i.value as! Data
                self.data = data
            }
            
            if i.commonKey?.rawValue == "title" {
                
                let title = i.value as! String
                self.title = title
            }
            
            if i.commonKey?.rawValue == "artist" {
                
                let artist = i.value as! String
                self.artist = artist
            }
        }
    }
    
    func ChangeSongs(){
        
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        
        self.player.delegate = self.del
        
        self.data = .init(count: 0)
        
        self.title = ""
        
        self.player.prepareToPlay()
        self.getData()
        
        self.playing = true
        
        self.timeLeft = "0:00"
        
        self.findTimeRight(delay: 1)
        
        self.finish = false
        
        self.player.play()
        
    }
    
    func findTimeLeft() {
        let forwardMinute = Int(self.player.currentTime + 1) / 60
        let forwardSecond = Int(self.player.currentTime + 1) % 60
        
        if(forwardSecond < 10) {
            self.timeLeft = String(format: "%d:0%d", forwardMinute, forwardSecond)
        }
        else {
            self.timeLeft = String(format: "%d:%d", forwardMinute, forwardSecond)
        }
    }
    
    func findTimeRight(delay: Double) {
        let reverseMinute = (Int(self.player.duration + 1 + delay) - Int(self.player.currentTime + 1)) / 60
        let reverseSecond = (Int(self.player.duration + 1 + delay) - Int(self.player.currentTime + 1)) % 60
        
        if(reverseSecond < 10) {
            self.timeRight = String(format: "-%d:0%d", reverseMinute, reverseSecond)
        }
        else {
            self.timeRight = String(format: "-%d:%d", reverseMinute, reverseSecond)
        }
    }
    
}
struct BlurPageButton : View {
        var image : String
        var text : String
    var body: some View{
            HStack{
                Image(systemName: image)
                    .font(.system(size: 25, weight: Font.Weight.thin))
                    .foregroundColor(.white)
                Text(text).font(.title3).bold()
                    .foregroundColor(.white)
                Spacer()
                
            }.padding()
    }
}

class AVdelegate : NSObject, AVAudioPlayerDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}


struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(songName: "Anadolu Rock", albumImage: "cemKaraca")
    }
}

