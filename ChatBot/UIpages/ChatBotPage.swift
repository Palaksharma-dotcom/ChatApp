//
//  ChatBotPage.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI
import CoreData
struct ChatBotPage: View {
    @State var message = ""
    @EnvironmentObject private var setting: UserSettings
    @StateObject private var vm = QuestionViewModel()
    @StateObject private var vmg = ChatBotModel()
   
    @FetchRequest(sortDescriptors: []) var questions: FetchedResults<Questions>
    @State private var category = [false, false, false,false]
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    Text(setting.user.username).foregroundColor(.black)
                  
                        .bold()
                }
               
                
            }.padding()
            ScrollView{
                ScrollViewReader { value in
                    ForEach(vm.questions, id: \.id) { item in
                        botQuesStyle(text: item.question, isBot: item.fromBot) {
                            vm.questionRecurr(question: item)
                        }
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                value.scrollTo(40)
                            }
                        }
                    }
                    
                }
                HStack {
                    NavigationLink(destination: MainChat(chat: ChatViewModel(chat: vm.chat ?? vm.optionalChat, settings: setting), vmg: setting), isActive: $vm.showChatView) {
                        Button(action: {
                            vm.createChat(setting: self.setting)
                        }, label: {
                            Text("Contact support")
                        }).foregroundColor(.white).frame(width: 250, height: 50).background(Color("Darkblue")).cornerRadius(15).padding()
                        //
                    }
                }
                Spacer()
            }.navigationBarItems(trailing: Button("Logout", action: {
//                vmg.logoutUser(settings: setting)
                vmg.LogOutAlert = true
            })    .alert("Are you sure you want to Log Out??", isPresented: $vmg.LogOutAlert) {
                Button("LogOut") {
                    vmg.logoutUser(settings: setting)
                                            
                }
                
                Button("Cancel", role: .cancel) {}
            }
            ).onAppear(){
                vm.showStartingQuestions(allQuestions: self.questions)
            }
            
            
            HStack{
                TextField("Enter Message", text: $message)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .onSubmit {
                        
                    }
                Button{
                    
                }label: {
                    Image(systemName: "paperplane.fill").padding(10).background(Color.white)
                                                .cornerRadius(100)
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
                
            }.padding()
        }.background(Color("Lightblue"))
        }
    }

struct ChatBotPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotPage()
    }
}

//                VStack(alignment: .leading) {
//                    VStack{
//
//                    }.onAppear(){
//                        var it = vm.savePredefinedQuestion()
//                        var q = vm.loadQuestions(parent: nil)
//                        print(q.count)
//                        print(it)
//                        print(q)
//                    }
//
    
