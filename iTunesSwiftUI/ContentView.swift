//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Struct that holds our view
// Structs are value-based
// Classes are reference-based
//
// Class UILabel -> Instance
// let label = UILabel()
//label.placeholderText = ""
//
// Struct (var) Text -> modifications -> Text
struct ContentView: View {
    
    // A State is the source of truth
    // If it changes, the whole view is going to be redrawn
    @State var artistName: String = ""
    
    @State var artistGenre: String = ""
    
    var body: some View {
        VStack() {
            Text("Search for artists in iTunes")
                .font(.subheadline)
            
            // Textfield is expecting a binding
            // A binding will help SwiftUI know that it needs to update one of our own custom variables.
            // In order for us to have a custom variable like that, we need to use @State to wrap it
            // $ -> Getter for the underlying binding
            SearchView(artistNameBinding: $artistName, artistGenreBinding: $artistGenre)
            
            Text(artistName) // textfield updates the label to whats typed in the search bar
                .font(.largeTitle) // Modify the text (-> a new text with the modifications)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
                
            HStack() {
                Text("Artist Genre:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(artistGenre)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}

// Struct that holds our preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
