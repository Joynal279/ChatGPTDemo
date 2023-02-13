//
//  ContentVM.swift
//  ChatGPTDemo
//
//  Created by Joynal Abedin on 14/2/23.
//
import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject {
    
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
}

