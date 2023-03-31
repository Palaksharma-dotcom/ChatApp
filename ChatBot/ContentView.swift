//
//  ContentView.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var setting: UserSettings
    @StateObject private var vm = QuestionViewModel()
//    private var items: FetchedResults<Item>
//    @Binding var user: UserModel?
    var body: some View {
        NavigationView {
            if (setting.user.username != "username"){
                ChatList()
            }
            else{
                LogInView()

            }
//           SignUp()
//                ChatList()
//            ChatBotPage()
            

        }.onAppear(){
//            vm.savePredefinedQuestion()
        }
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }

   

    }




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
