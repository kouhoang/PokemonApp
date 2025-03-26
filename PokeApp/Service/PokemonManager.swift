//
//  PokemonService.swift
//  PokeApp
//
//  Created by admin on 26/02/25.
//


import Foundation
import SwiftyJSON
import Kingfisher

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
    
    struct PokemonEntry: Codable {
        let name: String
        let url: String
    }
}

class PokemonManager: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    
    private var currentPage = 0
    private let pageSize = 20
    
    func fetchPokemons() {
        guard !isLoading else { return }
        
        isLoading = true
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(pageSize)&offset=\(currentPage * pageSize)"
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { self?.isLoading = false }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    let newPokemons = response.results.enumerated().map { (index, result) in
                        Pokemon(
                            id: self!.currentPage * self!.pageSize + index + 1,
                            name: result.name,
                            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self!.currentPage * self!.pageSize + index + 1).png"
                        )
                    }
                    
                    self?.pokemons.append(contentsOf: newPokemons)
                    self?.currentPage += 1
                    self?.isLoading = false
                }
            } catch {
                DispatchQueue.main.async { self?.isLoading = false }
            }
        }.resume()
    }
    
    func fetchPokemonDetails(for pokemon: Pokemon, completion: @escaping (PokemonDetails?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let details = try JSONDecoder().decode(PokemonDetails.self, from: data)
                DispatchQueue.main.async {
                    completion(details)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
