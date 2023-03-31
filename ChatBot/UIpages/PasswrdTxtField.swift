//
//  PasswrdTxtField.swift
//  ChatBot
//
//  Created by Rapipay on 31/03/23.
//

import SwiftUI

struct PasswrdTextField: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    //    @Binding private var showError: Bool
    @StateObject private var lg = LogInViewModel()
    private var title: String
    @FocusState private var showLabel
    @State var borderColor = Color.gray
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
        
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .padding()
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                .stroke(borderColor, lineWidth: 2)
//                        }
                    
                }
                else {
                    TextField(title, text: $text)
                        .padding()
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 8, style: .continuous)
//                                .stroke(borderColor, lineWidth: 2)
//
//                        }
                    
                }
                
            }
            //            .onChange(of: text, perform: { data in
            //                showError = false
            //                borderColor = showError ? Color(.red) : Color(.blue)
            //                if we are editing the textfield it will turn blue till we edit it
            //            })
//            .focused($showLabel)
//            if showLabel {
//                HStack {
//                    Text(title)
//                        .padding(.horizontal, 5)
//                        .background(Color.white)
//                    Spacer()
//                }.padding(.bottom, 50)
//                    .padding(.leading, 20)
//                    .onAppear(){
//                        borderColor = lg.secretError ? Color(.red) : Color(.blue)
//                    }.onDisappear() {
//                        //                        ye condition else ki traha kaam kregi
//                        borderColor = lg.secretError ? Color(.red) : Color(.gray)
//                    }
//            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                //                label:
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }.padding()
        }
    }
}
    
    
    
//
//    struct PasswrdTextField_Previews: PreviewProvider {
//        static var previews: some View {
//            PasswrdTextField("hi", text: .constant(""), showError: .constant(false))
//        }
//    }
//}
