//
//  ChatList.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI

struct ChatList: View {
    @State var search = ""
//    @State var msg: MessageModel
    @EnvironmentObject private var setting: UserSettings
    @State var chatList:[ChatListRowView] = []
    @StateObject private var vm = ChatBotModel()
    @FetchRequest(sortDescriptors: []) var questions: FetchedResults<Questions>
    
//    @ObservedObject var chat: ChatViewModel
//    @Published var singupAlert = false
//    @State var chatList:[ChatModel] = []
//    @State var selectedChat: ChatModel?
    
    var body: some View {
        ZStack{
        VStack{
            HStack{
                Text("Chats").frame(alignment: .center)
                    
                    .bold()
                Button("Logout", action: {

                    vm.LogOutAlert = true
                })
                .padding(.leading, 200)
                    .alert("Are you sure you want to Log Out??", isPresented: $vm.LogOutAlert) {
                        Button("LogOut") {
                            vm.logoutUser(settings: setting)
                                                    
                        }
                        
                        Button("Cancel", role: .cancel) {}
                    }
            }
            ZStack(alignment: .trailing){
                TextField("Search", text: $search)
                    .frame(width: 330, height: 30)
                    .padding()
                    .background(.white)
                    .cornerRadius(15)
                Image(systemName: "magnifyingglass").padding(.trailing, 20).foregroundColor(.gray)
            }
            VStack{
                Spacer()
                if (vm.chats.count != 0){
                   
                    List(vm.chats) { item in
                        NavigationLink(destination: MainChat(chat: ChatViewModel(chat: item, settings: setting),vmg: setting)) {
                            ChatListRowView(title: item.title, lastMsg: item.lastMessage)
                        }
                    }.listStyle(.plain).padding().cornerRadius(20)
                }
                else{
                    Text("No Chats available")
                        .padding(.top, -400)
                        .frame(alignment: .center)
                }
            }
            
            NavigationLink(destination: ChatBotPage(), label: {
                Text("+")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Darkblue"))
                    .clipShape(Circle())
                    .padding(.leading, 300)
                    .padding( .bottom, 30)
                
            })
        }
        .onAppear() {
            if vm.isLoading{
                ProgressView()
            }
           
            vm.loadChats(questions: questions , settings: setting)
            }
            
//            vm.loadChats(settings: setting)
        
        }.background(Color("Lightblue"))
    }
}

//struct ChatList_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatList()
//    }
//}




//                if (chatList.count > 0){
//                ForEach(chat.rowdata) { list in
//                        ChatListRowView(title: "", lastMsg: selectedChat.lastMessage )


//                }
//                List(0..<chatList.count, id: \.self) {
//                    item in
//                    Text("\(chatList[item].id)").onTapGesture {
//                        selectedChat = chatList[item]
//                    }
//                }

