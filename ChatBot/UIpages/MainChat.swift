//
//  MainChat.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI

struct MainChat: View {
//    @State var usermsg = ""
    @ObservedObject var chat: ChatViewModel
    @ObservedObject var vmg: UserSettings
//    var users: UserModel
    var body: some View {
        VStack{
            ScrollView{
                ScrollViewReader{ value in

                    ForEach(chat.message, id: \.id){ msg in
                        MessageCellView(message: msg.text, sender: !(msg.sender == chat.settings.user.username), created: msg.created, date: "")
                    }.onAppear{
                        
//                        FOR LAST MESSAGE TO APPEAR ON THE SCREEN _^|\                        value.scrollTo(vm.message[vm.message.count - 1].id)

                        
                    }
                }
            }
            ZStack{
                HStack{
                    TextField("Enter Message", text: $chat.messageentered)
                        .onChange(of: chat.messageentered) {
                            data in chat.showTyping()
                        }
//                        .onChange(of: chat.isOnline){
//                            
//                        }
//                    
                        .padding()
//                        .background(Color.white)
                        .onSubmit {
                            chat.sendMessages()
                        }
                    Spacer()
                    Button{
                        chat.sendMessages()
                    }label: {
                        Image(systemName: "paperplane.fill")
                    }
                    .font(.system(size: 26))
                    .padding(.horizontal, 10)
                    
                }  .background(Color.white)
                    .cornerRadius(15).padding()
                    .onAppear() {
                        chat.startSocket()
                    }
                    .onDisappear() {
                        chat.closeConnection()
                    }
                //
                    .navigationBarTitle(chat.isTyping ? "is typing" : String(chat.chat.id), displayMode: .inline)
                    .navigationBarItems(trailing:  chat.isOnline ? Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10) : Circle()
                        .fill(Color.gray)
                        .frame(width: 10, height: 10))
                
            }
//            vmg.user.username
        }.background(Color("Lightblue"))
//        .padding(.top, 200)
//            .padding(.bottom, 300)
    }
    
  
    
    
}


//struct MainChat_Previews: PreviewProvider {
//    static var previews: some View {
//        MainChat()
//    }
//}
