//
//  UserSettings.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import Foundation
class UserSettings: ObservableObject {
    @Published var user: UserModel
    
    init() {
        self.user = UserModel(
            username: UserDefaults.standard.value(forKey: "username") as? String ?? "username",
            secret: UserDefaults.standard.value(forKey: "secret") as? String ?? "secret",
            first_name: UserDefaults.standard.value(forKey: "firstname") as? String ?? "firstname",
            last_name: UserDefaults.standard.value(forKey: "lastname") as? String ?? "lastname" )
    }
    
    
    func setUser(user:UserModel ){
        self.user = user
    }
    
}
