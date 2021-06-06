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
        NavigationView {
            List {
//            List (people, id: \.self){
//            List (0..<5){
                ForEach(people, id: \.self) { person in
                    Text("List row \(person)")
                }
//                Section (header: Text("Static Section 1")) {
//                    Text("Static Row 1")
//                    Text("Static Row 2")
//                }
//
//                Section (header: Text("Dynamic Section 1")) {
//                    ForEach(0..<20) {
//                        Text("Dynamic row \($0 + 1)")
//                    }
//                }
//
//                Section (header: Text("Static Section 2")) {
//                    Text("Static Row 3")
//                    Text("Static Row 4")
//                }
            }.edgesIgnoringSafeArea(.all)
            .listStyle(GroupedListStyle())
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
