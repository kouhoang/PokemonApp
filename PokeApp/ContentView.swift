//
//  ContentView.swift
//  PokeApp
//
//  Created by admin on 26/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokemonListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            
            PokemonGridView()
                .tabItem {
                    Image(systemName: "square.grid.3x3.fill")
                    Text("Grid")
                }
        }
    }
}

#Preview {
    ContentView()
}
