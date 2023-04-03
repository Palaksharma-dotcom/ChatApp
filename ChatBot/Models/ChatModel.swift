//
//  ChatModel.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import Foundation

struct ChatModel: Identifiable{
    
    var id: Int
    var sender: String
    var receiver: String
    var title: String
    var accessKey: String
    var lastMessage: String
    
}
//chat title, agent name, typing


//    var id = 0
//    var admin:[String:Any] = [:]
//    var people:[[String: Any]] = []
//    var attachments:[Any] = []
//    var last_message:[String:Any] = [:]
//    var title = ""
//    var is_direct_chat = false
//    var custom_json:[String:Any] = [:]
//    var access_key = ""
//    var is_authenticated = true
//    var created = ""
//
