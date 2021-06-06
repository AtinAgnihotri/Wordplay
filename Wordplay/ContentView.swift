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
        var message = ""
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            message = "We found the file"
            if let fileContent = try? String(contentsOf: fileURL) {
                message += "\nWe've loaded the file content"
            }
        } else {
            message = "File was not found"
        }
        
        return Text(message)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
