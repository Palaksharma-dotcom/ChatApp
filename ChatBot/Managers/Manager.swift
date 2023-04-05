//
//  Manager.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import Foundation
import SwiftUI

enum SocketAction: String {
    case typing = "is_typing"
    case recievedMsg = "new_message"
}

class SocketManager: NSObject, URLSessionWebSocketDelegate {
    static let shared = SocketManager()
    private var webSocket: URLSessionWebSocketTask?
    var completionHandler: ((String)->())?
//    it establishes the connection with the other on the basis of chatid and secretkey
    func setUpConnection(chatId: String, chatAccessKey: String, completionHandler: @escaping ((String)->())) {
        self.completionHandler = completionHandler
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let url = URL(string: "wss://api.chatengine.io/chat/?projectID=\(Keys.projectId)&chatID=\(chatId)&accessKey=\(chatAccessKey)")
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
    }
    func recieve() {
//        to receive message from other side
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("data received: \(data)")
                case .string(let message):
                    self!.completionHandler!(message)
                @unknown default:
                    print("Default")
                    break
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
            self?.recieve()
        })
    }

    func send() {
//        to send message
        webSocket?.send(.string("Message from User"), completionHandler: { error in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Message sent successfully")
            }
        })
    }
    func ping() {
//        to point error
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                print("Ping error: \(error)")
            }
        })
    }
    
    func close() {
//        to terminate the connection
        webSocket?.cancel(with: .goingAway, reason: "Byye".data(using: .utf8))
    }
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
//        displays message when connection is established
        print("Connection Established Successfully")
        ping()
        recieve()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Connection is Terminated")
    }
}


//          another method

//    func receiveMessages() {
//         webSocket?.receive { [weak self] result in
//             guard let self = self else { return }
//
//             switch result {
//             case .failure(let error):
//                 print("\(error)")
//
//             case .success(let message):
//                 switch message {
//                 case .data(let data):
//                     let decoder = JSONDecoder()
//                     if let receivedMessage = try? decoder.decode(message.self, from: data) {
//                         DispatchQueue.main.async {
//                             self.message.append(receivedMessage)
//                         }
//                     }
//
//                 case .string(let string):
//                     print("message:\(string)")
//
//                 case .close(let closeCode, let reason):
//                     print(" \(closeCode)")
//
//                 @unknown default:
//                     fatalError()
//                 }
//
//                 self.receiveMessages()
//             }
//         }
//     }
    
