//
//  ChatBotApp.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI

@main
struct ChatBotApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
