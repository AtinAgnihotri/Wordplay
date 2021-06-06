//
//  WordplayApp.swift
//  Wordplay
//
//  Created by Atin Agnihotri on 06/06/21.
//

import SwiftUI

@main
struct WordplayApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
