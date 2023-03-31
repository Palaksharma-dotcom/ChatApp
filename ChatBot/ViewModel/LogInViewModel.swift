//
//  LogInViewModel.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import Foundation
enum LogIn {
    case username
    case secret
    case firstName
    case lastName
}
class LogInViewModel: ObservableObject {
    @Published var username = ""
   
    @Published var secret = ""
    @Published var loginAlert = false
    @Published var usernameError = false
    @Published var secretError = false
    
    func loginuser(settings: UserSettings) -> LogIn? {
        NetworkManager.shared.requestForApi(requestInfo: ["httpMethod": "GET","domain": "users/me","requestType": .loginUser as RequestType, "username": username,"userSecret": secret], completionHandler: {
            
            data in
                guard let data = data as? [String: Any] else {return}
                if let suc = data["first_name"] as? String {
                    self.saveData(UserModel(username: self.username, secret: self.secret , first_name: data["first_name"] as! String, last_name: data["last_name"] as! String), settings: settings)
                    print(data)
                } else {
                    self.loginAlert = true
                }
            
                
            
        })
        return nil
    }
    

    
    
    func saveData(_ user: UserModel, settings: UserSettings) {
        UserDefaults.standard.set(user.username, forKey: "username")
        UserDefaults.standard.set(user.first_name, forKey: "firstName")
        UserDefaults.standard.set(user.last_name, forKey: "lastName")
        UserDefaults.standard.set(user.secret, forKey: "secret")
        settings.setUser(user: user)
    }
    
    func isValidUsername(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{7,18}")
        return test.evaluate(with: input)
    }
    func isValidPassword(input: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: input)
    }
}
