//
//  QuestionRow.swift
//  ChatBot
//
//  Created by Rapipay on 30/03/23.
//

import SwiftUI

struct botQuesStyle: View {
    var text: String
    var isBot: Bool
    var action: (()->())
    var body: some View {
        HStack {
            if !isBot {
                Spacer()
            }
            HStack {
                Button(action: action, label: {
                    Text(text)
                })
                .foregroundColor(isBot ? .black.opacity(0.8) : Color(.white).opacity(0.8)).padding()
                .background(isBot ? .white : Color("Darkblue"))
            }.padding()
             
           
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isBot ? Color(.black) : Color("Darkblue"), lineWidth: 2))
            .background(isBot ? .white : Color("Darkblue"))
            .cornerRadius(10)
            .padding(.horizontal, 4)
            if isBot{
                Spacer()
            }
        }
    }
}
//struct QuestionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionRow()
//    }
//}
