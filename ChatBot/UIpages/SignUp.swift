//
//  SignUp.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import SwiftUI

struct SignUp: View {
//    StateObject for one screen we use StateObject as it don't reload the data when view is reloaded
// ObservedObject used in
    @StateObject private var signup = SignUpViewModel()
    @FocusState var fieldtf: Focused?
//    go back to the navigation view
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            VStack{
                Image("chatlogo")
                    .resizable().scaledToFit().frame(width: 100, height: 100)
                Text("Welcome to Chat App").font(.title3).bold()
                    .padding(4)
                Text("Please fill the details and create account").font(.caption2)
            }.padding(30)
            
//          To enter username and show red box when the username entered is not according to the             defined parameters
            
            
            TextField("User name", text: $signup.usernametf)
                .onChange(of: signup.usernametf) { data in
                    signup.usernameError = false
                }
                .onSubmit {
                    signup.usernameError = !signup.validateUsername(input: signup.usernametf)
                }
                .padding()
                .border(signup.usernameError ? Color(.red) : Color(.black))
                .cornerRadius(4)
            
//            To enter firstname and how red box when the username entered is not registered
            TextField("First name", text: $signup.firstNametf)
                .onChange(of: signup.firstNametf) { data in
                    signup.firstNameError = false
                }
                .onSubmit {
                    signup.firstNameError = !signup.validateName(input: signup.firstNametf)
                }
                .padding()
                .border(signup.firstNameError ? Color(.red) : Color(.black))
              
                .cornerRadius(4)
            
//             To enter second name and show red box when the username entered is not according to               the defined parameters
            TextField("Second name", text: $signup.lastNametf)
                .onChange(of: signup.lastNametf) { data in
                    signup.lastNameError = false
                }
                .onSubmit {
                    signup.lastNameError = !signup.validateName(input: signup.lastNametf)
                }
                .padding()
                .border(signup.lastNameError ? Color(.red) : Color(.black))
                .cornerRadius(4)

//            To enter password and show red box when the username entered is not according to               the defined parameters
            PasswrdTextField("Password", text: $signup.secrettf)
                .onChange(of: signup.secrettf) { data in
                    signup.secretError = false
                }
                .onSubmit {
                    signup.secretError = !signup.validatePassword(input: signup.secrettf)
                }
//                .padding()
                .border(signup.secretError ? Color(.red) : Color(.black))
                .cornerRadius(4)
            Button("Sign up", action: {
                fieldtf = nil
                DispatchQueue.main.asyncAfter(deadline: .now()+0.001)
                {
                    fieldtf = signup.signupUser()
                    
                }
            }).foregroundColor(.white).frame(width: 300, height: 50).background(Color("Darkblue")).cornerRadius(15).padding()
            .alert("Signed up successfully", isPresented: $signup.singupAlert) {
                Button("GO TO SIGN IN") {
                    self.presentation.wrappedValue.dismiss()
                }
            }.alert("Username Already Taken", isPresented: $signup.singupErrorAlert) {}
            HStack{
                Text("Already have an account").font(.subheadline)
                NavigationLink(destination: LogInView(), label: {
                    Text("Log In").foregroundColor(Color("Darkblue"))
                })
            }
        }.padding(50)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
