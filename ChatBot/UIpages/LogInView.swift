//
//  LogInView.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import SwiftUI

struct LogInView: View {
    @StateObject private var lg = LogInViewModel()
    @FocusState var logbtn: LogIn?
    @EnvironmentObject private var setting: UserSettings
    var body: some View {
        VStack{
            VStack{
                Image("chatlogo")
                    .resizable().scaledToFit()
                    .frame(width: 100,height: 100)
                Text("Welcome to ChatApp").font(.title2).bold()
                Text("Login to access chatbot")
            }.padding()
            
//            to vadidate the login credentials entered by the user 
            TextField("User name",text: $lg.username)
                .onChange(of: lg.username){
                    data in
                    lg.usernameError = false
                }
                .onSubmit {
                    lg.usernameError = !lg.isValidUsername(input: lg.username)
                }
                .padding()
                .border(lg.usernameError ? Color(.red) : Color(.black))
                .cornerRadius(4)
            
            PasswrdTextField("Password", text: $lg.secret)

                .onChange(of: lg.secret){
                    data in
                    lg.secretError = false
                }

                .onSubmit {
                    lg.secretError = !lg.isValidPassword(input: lg.secret)
                }
//                .padding()
                .border(lg.secretError ? Color(.red) : Color(.black))
                .cornerRadius(4)
            Button("Log In", action: {
                logbtn = nil
                
                logbtn = lg.loginuser(settings: self.setting)
                
                
            }).foregroundColor(.white).frame(width: 300, height: 50).background(Color("Darkblue")).cornerRadius(15).padding()
            HStack{
                Text("Need an account").font(.subheadline)
            NavigationLink( destination: SignUp(), label: {
                Text("Sign Up").foregroundColor((Color("Darkblue")))
            })
        }
        }.padding(50)
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
