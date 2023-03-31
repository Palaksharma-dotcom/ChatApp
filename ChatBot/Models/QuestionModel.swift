//
//  QuestionModel.swift
//  ChatBot
//
//  Created by Rapipay on 28/03/23.
//
import Foundation

struct QuestionModel: Identifiable {
    var id: UUID
    var parent: UUID?
    var question: String
    var fromBot: Bool
    
    init(id: UUID, parent: UUID? = nil, que: String, fromBot: Bool = true) {
        self.id = id
        self.parent = parent
        self.question = que
        self.fromBot = fromBot
    }
}

