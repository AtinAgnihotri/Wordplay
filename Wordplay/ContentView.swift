//
//  ContentView.swift
//  Wordplay
//
//  Created by Atin Agnihotri on 06/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    let people  = ["Tom", "Dick", "Hardy"]
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List (userWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                        .padding()
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        var userAns = newWord
                            .lowercased()
                            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard userAns.count > 0 else {
            return
        }
        
        // other validations
        userWords.insert(userAns, at: 0)
        newWord = ""
        
    }
    
    func startGame() {
        if let startGameURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startText = try? String(contentsOf: startGameURL) {
                let startWords = startText.components(separatedBy: "\n")
                rootWord = startWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from the bundle")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
