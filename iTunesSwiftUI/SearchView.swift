//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Kevin Stewart on 5/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Access Control
//
// private - only accessible inside your class
// fileprivate - only accessible inside the same file
// internal - only accessible in the same module
// public - accessible everywhere in all modules
// open - accessible everywhere _and_ subclassable
// final - it cannot be subclassed

final class SearchView: NSObject, UIViewRepresentable {
    
    // Two-way street between two variables
    // Binding itself is just a wrapper around 'artistName: String'
    @Binding var artistName: String
    @Binding var artistGenre: String
    
    
    
    init(artistNameBinding: Binding<String>, artistGenreBinding: Binding<String>) {
        // In order to assign a binding to our variable
        _artistName = artistNameBinding
        _artistGenre = artistGenreBinding
    }
    
    // Tell the compiler what view we'll be using while being UIViewRepresentable
    // Generics via AssociatedType.
    typealias UIViewType = UISearchBar
    
    // Creat our UIView
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .sentences
        searchBar.delegate = self
        return searchBar
    }
    
    // Update it every single time that SwiftUI updates it
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.delegate = self
    }
}

// In order to become a UIsearchBarDelegate
// 1. Be a class
// 2. Be a final class
// 3. Inherit from NSObject
extension SearchView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Fetch the user's input and send it to iTunes
        iTunesAPI.searchArtists(for: searchBar.text!) { result in
            
            // When the iTunes server responds, we either get an array of artists or an error
            switch result {
                
            case .success(let artists):
                
                // If we got an array of artists, make sure there is at least one artist
                guard let firstArtist = artists.first else { return }
                
                // Update our 'artistName' string, which triggers its own binding
                self.artistName = firstArtist.artistName
                self.artistGenre = firstArtist.primaryGenreName
                
            case .failure(let error):
                print(error)
            }
        }
        
        searchBar.endEditing(true)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
