//
//  Pokemon.swift
//  PokeApp
//
//  Created by admin on 26/02/25.
//

import Foundation

struct Pokemon: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let imageUrl: String
    var details: PokemonDetails?
    
    var capitalizedName: String {
        return name.capitalized
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

struct PokemonDetails: Codable, Equatable {
    let height: Int
    let weight: Int
    let types: [TypeEntry]
    let abilities: [AbilityEntry]
    
    struct TypeEntry: Codable, Equatable {
        let type: NamedResource
    }
    
    struct AbilityEntry: Codable, Equatable {
        let ability: NamedResource
    }
    
    struct NamedResource: Codable, Equatable {
        let name: String
    }
}
