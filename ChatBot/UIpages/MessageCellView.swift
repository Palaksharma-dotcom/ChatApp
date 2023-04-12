//
//  MessageCellView.swift
//  ChatBot
//
//  Created by Rapipay on 26/03/23.
//

import SwiftUI

struct MessageCellView: View {
    var message: String
    var sender: Bool
    var created: String
    var date: String
    var body: some View {
        HStack{
            if !sender{
                Spacer()
            }
            VStack{
                Text(message)
                    .foregroundColor(sender ? Color.black : Color.white)
                Text(created)
                    .padding(.top, 0.5)
                    .padding(.bottom,2)
                    .foregroundColor(sender ? .black : .white.opacity(0.6))
                    .font(.caption2)
            }.padding(.top).padding(.horizontal)
                .background(sender ? Color.white : Color("Darkblue"))
                .cornerRadius(15)
                .contextMenu {
                    Text("Sent on \(date)")
                }
            if sender {
                Spacer()
            }
            }
        }
    }


struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView(message: "hi", sender: true, created: "today", date: "dd/mm/yy")
    }
}

