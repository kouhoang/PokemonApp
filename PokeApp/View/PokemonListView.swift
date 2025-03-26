//
//  PokemonListView.swift
//  PokeApp
//
//  Created by admin on 26/02/25.
//


import SwiftUI
import Kingfisher

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    @StateObject private var manager = PokemonManager()
    
    var body: some View {
        NavigationView {
            List {
                pokemonContent
            }
            .navigationTitle("Pokémon List")
            .onAppear {
                if manager.pokemons.isEmpty {
                    manager.fetchPokemons()
                }
            }
        }
    }
    
    // Break down the complex view into a separate computed property
    private var pokemonContent: some View {
        Group {
            ForEach(manager.pokemons) { pokemon in
                pokemonRow(pokemon)
            }
            
            if manager.isLoading {
                loadingIndicator
            }
        }
    }
    
    // Extract row creation to a separate method
    private func pokemonRow(_ pokemon: Pokemon) -> some View {
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
            HStack {
                KFImage(URL(string: pokemon.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Text(pokemon.capitalizedName)
            }
        }
        .onAppear {
            if pokemon == manager.pokemons.last {
                manager.fetchPokemons()
            }
        }
    }
    
    // Separate loading indicator
    private var loadingIndicator: some View {
        ProgressView()
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
