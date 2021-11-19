//
//  RegisterPage.swift
//  SpotifyClone
//
//  Created by Tham Thearawiboon on 18/11/2564 BE.
//

import SwiftUI

struct RegisterPage: View {
    @State var email = ""
    @State var username = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var buttonWidth = UIScreen.main.bounds.width - 60 // same width textField
    var body: some View {
        NavigationView{
            VStack{
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.black)
                    .padding(40)
                
                VStack{
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(8.0)
                        .padding(.horizontal, 30)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(8.0)
                        .padding(.horizontal, 30)
                
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(8.0)
                        .padding(.horizontal, 30)
                    
                }.padding(.bottom, 25)
                
                Button{
                    viewModel.register(withEmail: email, password: password, username: username)
                } label:{
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: buttonWidth, height: 50)
                        .background(Color.green)
                        .cornerRadius(8.0)
                }
                
                Spacer()
                
                NavigationLink(
                destination: SignInPage().navigationBarHidden(true),
                label:{
                        Text("Sign In")
                            .font(.system(size: 14))
                    }
                )
            }
        }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
            .environmentObject(AuthViewModel.share)
    }
}
