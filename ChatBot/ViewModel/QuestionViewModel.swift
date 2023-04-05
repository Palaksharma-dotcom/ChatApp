//
//  QuestionViewModel.swift
//  ChatBot
//
//  Created by Rapipay on 28/03/23.
//
//      NewChatViewModel
import Foundation
import SwiftUI
import CoreData

class QuestionViewModel: ObservableObject {
    @Published var showChatView = false
    @Published var chat: ChatModel?
    @Published var questions: [QuestionModel] = []
    var allQuestions: FetchedResults<Questions>?
    var optionalChat = ChatModel(id: 1, sender: "Sender", receiver: "Reciever", title: "Title456", accessKey: "7", lastMessage: "No messages")
    
    
    var chatTitle = "Support"

    
    func loadQuestions(parent: UUID?) -> [FetchedResults<Questions>.Element] {
        let ques = allQuestions!.filter { question in
            return question.parent == parent
        }
        return ques
    }
    
//will show the first 4 initial questions
    func showStartingQuestions(allQuestions: FetchedResults<Questions>) {
        self.allQuestions = allQuestions
        questions = []
//        questions whose parent id in nil
        let ques = loadQuestions(parent: nil)
        for que in ques {
            questions.append(QuestionModel(id: que.id!, parent: que.parent, que: que.question!))
        }
    }
    
    
    func questionRecurr(question: QuestionModel) {
        if question.fromBot {
            let item = loadQuestions(parent: question.id)
//            question which are having sub child are send as a chat from user side
            if item.count != 0 {
                questions.append(QuestionModel(id: UUID(), parent: UUID(), que: question.question, fromBot: false))
                chatTitle = question.question

            }
//            questions are saved in the chat
            for que in item {
                questions.append(QuestionModel(id: que.id!, parent: que.parent, que: que.question!))
            }
        }
    }
    
    func createChat(setting: UserSettings) {
        NetworkManager.shared.requestForApi(requestInfo: ["httpMethod": "PUT", "domain": "chats/", "requestType":
                .createChat as RequestType, "username": setting.user.username, "userSecret": setting.user.secret, "createChat": CreateChat(usernames: [setting.user.username == ChatRoom.user ? "Ashish_" : ChatRoom.user], title: chatTitle)], completionHandler: {data in print(data)
//                    chat title same both will enter in same room
                    guard let value = data as? [String: Any] else {return}
                    let admin = value["admin"] as? [String: Any]
                    let sender = admin?["username"] as? String ?? "Sender"
                    let people = value["people"] as? [[String: Any]]
                    let sam = people?[0] as? [String: Any]
                    let person = sam?["person"] as? [String: Any]
                    let receiver = person?["username"] as? String ?? "Receiver"
                    let title = value["title"] as? String ?? "Title"
                    let id = value["id"] as? Int ?? 0

                    let accessKey = value["access_key"] as? String ?? "8"
                    let lastMessageDetails = value["last_message"] as? [String: Any]
                    var lastMessage = lastMessageDetails?["text"] as? String ?? "No Message"
                    lastMessage = lastMessage.count == 0 ? "No Message" : lastMessage
                    self.chat = ChatModel(id: id, sender: sender,receiver: receiver, title: title, accessKey: accessKey, lastMessage: lastMessage)
                    self.showChatView = true
                })
    }
    
//    to save the questions when the app is killed and opened again
   func savePredefinedQuestion() {
        let levelOneData = [QuestionModel(id: UUID(), que: "NYE Prepaid Card"),
                    QuestionModel(id: UUID(), que: "Open Account"),
                    QuestionModel(id: UUID(), que: "Rapi Money"),
                    QuestionModel(id: UUID(), que: "UPI Payments")]

                            //NYE PREPAID CARD
        let levelTwoData = [QuestionModel(id: UUID(), parent: levelOneData[0].id, que: "Check Balance"),
                            QuestionModel(id: UUID(), parent: levelOneData[0].id, que: "Change PIN"),
                            QuestionModel(id: UUID(), parent: levelOneData[0].id, que: "Block Card"),
                            QuestionModel(id: UUID(), parent: levelOneData[0].id, que: "Issue a new Card"),

                            // OPEN ACCOUNT
                            QuestionModel(id: UUID(), parent: levelOneData[1].id, que: "Salary Account"),
                            QuestionModel(id: UUID(), parent: levelOneData[1].id, que: "Fixed Deposit"),
                            QuestionModel(id: UUID(), parent: levelOneData[1].id, que: "Recurring Deposit"),
                            QuestionModel(id: UUID(), parent: levelOneData[1].id, que: "Joint Account"),

                            // Rapi Money
                            QuestionModel(id: UUID(), parent: levelOneData[2].id, que: "Pick from the wide options of mutual funds"),
                            QuestionModel(id: UUID(), parent: levelOneData[2].id, que: "Get maximum profit by investing into suggested mutual funds"),

                            // UPI PAYMENTS
                            QuestionModel(id: UUID(), parent: levelOneData[3].id, que: "Add Bank Account"),
                            QuestionModel(id: UUID(), parent: levelOneData[3].id, que: "Change UPI pin"),
                            QuestionModel(id: UUID(), parent: levelOneData[3].id, que: "Link your number with UPI ID")]

                            // NYE PREPAID CARD - CHECK BALANCE
        let levelThreeData = [QuestionModel(id: UUID(), parent: levelTwoData[0].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[0].id, que: "Go to My Cards"),
                              QuestionModel(id: UUID(), parent: levelTwoData[0].id, que: "Click on view balance to check your balance"),

                              // NYE PREPAID CARD - CHANGE PIN
                              QuestionModel(id: UUID(), parent: levelTwoData[1].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[1].id, que: "Go to My Cards"),
                              QuestionModel(id: UUID(), parent: levelTwoData[1].id, que: "Click on change pin"),
                              QuestionModel(id: UUID(), parent: levelTwoData[1].id, que: "Enter new PIN"),
                              QuestionModel(id: UUID(), parent: levelTwoData[1].id, que: "Enter the OTP for completing the process."),

                              // NYE PREPAID CARD - BLOCK CARD
                              QuestionModel(id: UUID(), parent: levelTwoData[2].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[2].id, que: "Go to My Cards"),
                              QuestionModel(id: UUID(), parent: levelTwoData[2].id, que: "Click on block card and enter the reason"),

                              // NYE PREPAID CARD - ISSUE A NEW CARD
                              QuestionModel(id: UUID(), parent: levelTwoData[3].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[3].id, que: "Go to My Cards"),
                              QuestionModel(id: UUID(), parent: levelTwoData[3].id, que: "Click on request new card"),

                              // OPEN ACCOUNT - SALARY ACCOUNT

                              QuestionModel(id: UUID(), parent: levelTwoData[4].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[4].id, que: "Go to My Accounts"),
                              QuestionModel(id: UUID(), parent: levelTwoData[4].id, que: "Apply for Salary Account"),
                              QuestionModel(id: UUID(), parent: levelTwoData[4].id, que: "You will get a ticket for your request"),

                              // OPEN ACCOUNT - FIXED DEPOSIT
                              QuestionModel(id: UUID(), parent: levelTwoData[5].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[5].id, que: "Go to My Accounts"),
                              QuestionModel(id: UUID(), parent: levelTwoData[5].id, que: "Click on My Deposits"),
                              QuestionModel(id: UUID(), parent: levelTwoData[5].id, que: "Click on create new Deposit"),

                              // OPEN ACCOUNT - RECURRING DEPOSIT
                              QuestionModel(id: UUID(), parent: levelTwoData[6].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[6].id, que: "Go to My Account"),
                              QuestionModel(id: UUID(), parent: levelTwoData[6].id, que: "Click on My Deposits"),
                              QuestionModel(id: UUID(), parent: levelTwoData[6].id, que: "Click on create a recurring deposit"),

                              // OPEN ACCOUNT - JOINT ACCOUNT
                              QuestionModel(id: UUID(), parent: levelTwoData[7].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[7].id, que: "Select apply for new Account"),
                              QuestionModel(id: UUID(), parent: levelTwoData[7].id, que: "Select Joint Account from the options and follow the steps"),




                            // UPI - ADD BANK ACCOUNT

                              QuestionModel(id: UUID(), parent: levelTwoData[10].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[10].id, que: "Go to UPI"),
                              QuestionModel(id: UUID(), parent: levelTwoData[10].id, que: "Select Add Bank Account"),
                              QuestionModel(id: UUID(), parent: levelTwoData[10].id, que: "You will recieve a message on success"),

                            // UPI - CHANGE UPI PIN
                              QuestionModel(id: UUID(), parent: levelTwoData[11].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[11].id, que: "Go to UPI"),
                              QuestionModel(id: UUID(), parent: levelTwoData[11].id, que: "Click on change UPI"),
                              QuestionModel(id: UUID(), parent: levelTwoData[11].id, que: "Enter the new PIN"),
                              QuestionModel(id: UUID(), parent: levelTwoData[11].id, que: "Enter the OTP for completing the process"),

                            // UPI - LINK YOUR NUMBER WITH UPI ID
                              QuestionModel(id: UUID(), parent: levelTwoData[12].id, que: "Login to NYE Banking App"),
                              QuestionModel(id: UUID(), parent: levelTwoData[12].id, que: "Go to UPI"),
                              QuestionModel(id: UUID(), parent: levelTwoData[12].id, que: "Click on link number")]

        for question in levelOneData {
            PersistenceController.shared.saveQuestion(question: question.question, id: question.id, parent: question.parent)
        }
        for question in levelTwoData {
            PersistenceController.shared.saveQuestion(question: question.question, id: question.id, parent: question.parent)
        }
        for question in levelThreeData {
            PersistenceController.shared.saveQuestion(question: question.question, id: question.id, parent: question.parent)
        }
    }
}
//                       OTHER METHODS

//    func loadQuestions(parent: UUID?) -> [Questions] {
////        guard let parent = parent else { return [] }
////        let request: NSFetchRequest<Questions> = Questions.fetchRequest()
//        let request = Questions.fetchRequest() as NSFetchRequest<Questions>
//        request.predicate = NSPredicate(format: "parent == %@",parent! as CVarArg)
//
//
//        do {
//         var p = try PersistenceController.shared.container.viewContext.fetch(request)
//            print(p.count)
//            return p
//
//
//        } catch {
//            print("Error fetching questions: \(error.localizedDescription)")
//            return []
//
//        }
//
//    }

//    func showStartingQuestions(allQuestions: FetchedResults<Questions>) {
//        self.allQuestions = allQuestions
//        questions = []
//        let request: NSFetchRequest<Questions> = Questions.fetchRequest()
//        request.predicate = NSPredicate(format: "parent == nil")
//        do {
//            let fetchedQuestions = try PersistenceController.shared.container.viewContext.fetch(request)
//            for question in fetchedQuestions {
//                guard let id = question.id, let text = question.question else { continue }
//                let questionModel = QuestionModel(id: id, parent: question.parent, que: text)
//                questions.append(questionModel)
//            }
//        } catch {
//            print("Error fetching questions: \(error.localizedDescription)")
//        }
//    }
