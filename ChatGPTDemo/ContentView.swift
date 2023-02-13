//
//  ContentView.swift
//  ChatGPTDemo
//
//  Created by Joynal Abedin on 13/2/23.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(models, id: \.self) { string in
                Text(string)
            }
            
            Spacer()
            
            HStack {
                TextField("Type Here...", text: $text)
                Button("Send") {
                    send()
                }
                
            }
        }
        .onAppear {
            viewModel.setup()
        }
        .padding()
    }
    
    //Send
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        models.append("Me: \(text)")
        viewModel.send(text: text) { response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: "+response)
                self.text = ""
            }
        }
    }
}

//MARK: -  Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
