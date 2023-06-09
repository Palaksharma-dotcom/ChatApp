//
//  SignUpView.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import Foundation
//contains all detalis required during signin process
enum Focused {
    case username
    case secret
    case firstName
    case lastName
}

class SignUpViewModel: ObservableObject {
    @Published var usernametf = ""
    @Published var usernameError = false
    @Published var firstNametf = ""
    @Published var firstNameError = false
    @Published var lastNametf = ""
    @Published var lastNameError = false
    @Published var secrettf = ""
    @Published var secretError = false


    @Published var singupAlert = false
    @Published var singupErrorAlert = false
    
    
//    var focused: Focused?

    func signupUser() -> Focused? {
        
//        Username, firstname, last name and password validation
        
        if validateUsername(input: usernametf) {
            if validateName(input: firstNametf) {
                if validateName(input: lastNametf) {
                    if validatePassword(input: secrettf) {
//api is divided into 4 parts : httpMethod-> put,post,get
//                        domain-> user, me etc
//                        requestType-> to call specific api
//                        httpBody-> details(parameters) required in api
                        NetworkManager.shared.requestForApi(requestInfo: [
                            "httpMethod": "POST",
                            "domain": "users/",
                            "requestType": .createUser as RequestType,
                            "httpBody": [ "username": usernametf, "first_name": firstNametf, "last_name": lastNametf, "secret": secrettf]],
                            completionHandler: { item in
                            print(item)
                            guard let item = item as? [String: Any] else {return}
//             ---->it will check the items and if any field (last name here) is present it will retun signup alert else it will return error message
                            if let item = item["last_name"] as? String {
                                self.singupAlert = true
                            } else {
                                self.singupErrorAlert = true
                            }

                        })
                        return nil
                    } else {
                        secretError = true
                        return .secret
                    }
                } else {
                    lastNameError = true
                    return .lastName
                }
            } else {
                firstNameError = true
                return .firstName
            }
        } else {
            usernameError = true
            return .username
        }
    }
    
    func validUsername() {
        usernameError = !validateUsername(input: usernametf)
    }
    func validFirstName() {
        firstNameError = !validateName(input: firstNametf)
    }
    func validLastName() {
        lastNameError = !validateName(input: lastNametf)
    }
    func validSecret() {
        secretError = !validatePassword(input: secrettf)
    }
    
    func validateName(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{2,26}")
        return test.evaluate(with: input)
    }
    
    func validateUsername(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{7,18}")
        return test.evaluate(with: input)
    }
    
    func validatePassword(input: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: input)
    }
}



//internet error handling
//naming
//constant files-> url constant, base url method
//pub sub-> publiscation subscriber
//folder structure
//comments add
//delete unused code
//
