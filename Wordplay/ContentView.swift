//
//  ContentView.swift
//  Wordplay
//
//  Created by Atin Agnihotri on 06/06/21.
//

import SwiftUI

struct ContentView: View {
    
    let people  = ["Tom", "Dick", "Hardy"]
    
    var body: some View {
        var stuffWasLoaded = false
        var message = ""
        var wordList: [String] = []
        
        // Text Checker
        let word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            message = "We found the file"
            if let fileContent = try? String(contentsOf: fileURL) {
                message += "\nWe've loaded the file content"
                stuffWasLoaded = true
                wordList = fileContent.components(separatedBy: "\n")
                var fistLetter = wordList.randomElement()!
                let trimmed = fistLetter.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                wordList = [message, "We couldn't load the file content"]
//                message += "\nWe couldn't load the file content"
            }
        } else {
            wordList = ["File Not found"]
        }
        
        return List(wordList, id: \.self) {
            Text("\($0)")
        }
        
//        return stuffWasLoaded ? List{ ForEach(wordList, id: \.self){ Text("\($0)")}} : List { Text(message)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
