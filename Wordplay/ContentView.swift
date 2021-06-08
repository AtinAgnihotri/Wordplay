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
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showError = false
    @State private var score = 0
    
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
                
                Text("Your Score is \(score)")
                    .font(.largeTitle)
                    .padding()
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMsg), dismissButton: .default(Text("OK")))
            })
            .navigationBarItems(leading: Button("Restart") {
                startGame()
            })
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !userWords.contains(word)
    }
    
    func canBeMadeFromRootWord(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isActualWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func showError(title: String, message: String) {
        errorTitle = title
        errorMsg = message
        showError = true
    }
    
    func addNewWord() {
        let userAns = newWord
                            .lowercased()
                            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard userAns.count > 2 else {
            showError(title: "Too short", message: "Word can't be less than three letters")
            return
        }
        
        guard isOriginal(word: userAns) else {
            showError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isActualWord(word: userAns) else {
            showError(title: "Invalid Word", message: "\(userAns) is not an actual word")
            return
        }
        
        guard canBeMadeFromRootWord(word: userAns) else {
            showError(title: "Invalid Word", message: "\(userAns) can't be made from the root word")
            return
        }
        
        guard userAns != rootWord else {
            showError(title: "Come on", message: "You can't just use the root word")
            return
        }
        
        userWords.insert(userAns, at: 0)
        calculateScore()
        newWord = ""
        
    }
    
    func calculateScore() {
        var newScore = 0
        for word in userWords {
            newScore += word.count
        }
        score = newScore + userWords.count
    }
    
    func startGame() {
        if let startGameURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startText = try? String(contentsOf: startGameURL) {
                let startWords = startText.components(separatedBy: "\n")
                rootWord = startWords.randomElement() ?? "silkworm"
                score = 0
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
