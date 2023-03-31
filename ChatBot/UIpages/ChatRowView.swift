//
//  ChatRowView.swift
//  ChatBot
//
//  Created by Rapipay on 27/03/23.
//

import SwiftUI

struct ChatListRowView: View {
    var title: String
    var lastMsg: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2.weight(.bold))
                    .kerning(2)
                Text(lastMsg)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

struct ChatListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRowView(title: "Chat Title", lastMsg: "Last Message")
    }
}
