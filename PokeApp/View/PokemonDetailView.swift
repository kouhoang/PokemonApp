//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by admin on 26/02/25.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var pokemonDetails: PokemonDetails?
    @StateObject private var manager = PokemonManager()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                KFImage(URL(string: pokemon.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text(pokemon.capitalizedName)
                    .font(.largeTitle)
                
                if let details = pokemonDetails {
                    Group {
                        Text("Height: \(details.height)")
                        Text("Weight: \(details.weight)")
                        Text("Types: \(details.types.map { $0.type.name }.joined(separator: ", "))")
                        Text("Abilities: \(details.abilities.map { $0.ability.name }.joined(separator: ", "))")
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .onAppear {
                manager.fetchPokemonDetails(for: pokemon) { details in
                    self.pokemonDetails = details
                }
            }
        }
    }
}
