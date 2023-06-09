//
//  ChatBotModel.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import SwiftUI
class ChatBotModel: ObservableObject {
//    @Published var message: [ChatListRowView] = []
    @Published var LogOutAlert = false
    @Published var isLoading: Bool = false
    @Published var chats: [ChatModel] = []
    @Published var showNewChatView = false
    
//    func loadChats(questions: FetchedResults<Questions>,settings: UserSettings) {
//        if (questions.count == 0){
//            vm.savePredefinedQuestion()
//        }
//    func loadChats(settings: UserSettings) {
    
        func loadChats(questions: FetchedResults<Questions>,settings: UserSettings) {
            if (questions.count == 0){
                let vm = QuestionViewModel()
                vm.savePredefinedQuestion()
            }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            NetworkManager.shared.requestForApi(requestInfo: [
                "httpMethod": "GET",
                "domain": "chats/",
                "requestType": .getChats as RequestType,
                "username": settings.user.username,
                "userSecret": settings.user.secret],
                                                
                                                completionHandler: { data in
                guard let data = data as? [[String: Any]] else {return}
                var currentChats: [ChatModel] = []
                for value in data {
                    let admin = value["admin"] as? [String: Any]
                    let sender = admin?["username"] as? String ?? "Sender"
                    let people = value["people"] as? [[String: Any]]
                    //                    ---->
                    let sam = people?[0] as? [String: Any]
                    let person = sam?["person"] as? [String: Any]
                    let receiver = person?["username"] as? String ?? "Receiver"
                    let title = value["title"] as? String ?? "Title"
                    let id = value["id"] as? Int ?? 0
                    let accessKey = value["access_key"] as? String ?? "8"
                    let lastMessaggeDetails = value["last_message"] as? [String: Any]
                    //lastmessage will be  equal to the the new message entered by the user
                    var lastMessage = lastMessaggeDetails!["text"] as? String ?? "No Messages"
                    lastMessage = lastMessage.count == 0 ? "No Messages" : lastMessage
                    //                    new msg entered will be appended in the list of chat
                    currentChats.append(ChatModel(id: id, sender: sender, receiver: receiver, title: title, accessKey: accessKey, lastMessage: lastMessage))
                }
                self.chats = currentChats
            })
        }
    }
    
    func logoutUser(settings: UserSettings) {
//user name will be saved and all other details of user will be erased
        UserDefaults.standard.set("username", forKey: "username")
        UserDefaults.standard.set("", forKey: "firstname")
        UserDefaults.standard.set("", forKey: "lastname")
        UserDefaults.standard.set("", forKey: "secret")
        settings.setUser(user: UserModel(username: "username", secret: "", first_name: "", last_name: ""))
    }
}
