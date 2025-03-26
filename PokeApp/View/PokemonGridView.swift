//
//  PokemonGridView.swift
//  PokeApp
//
//  Created by admin on 27/02/25.
//

import SwiftUI
import Kingfisher

struct PokemonGridView: View {
    @StateObject private var manager = PokemonManager()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(manager.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            VStack {
                                KFImage(URL(string: pokemon.imageUrl))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                
                                Text(pokemon.capitalizedName)
                                    .font(.caption)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .onAppear {
                            if pokemon == manager.pokemons.last {
                                manager.fetchPokemons()
                            }
                        }
                    }
                    
                    if manager.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding()
            }
            .navigationTitle("Pokémon Grid")
            .onAppear {
                if manager.pokemons.isEmpty {
                    manager.fetchPokemons()
                }
            }
        }
    }
}
