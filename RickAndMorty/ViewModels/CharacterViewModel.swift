//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import Foundation
import SwiftUI
import Combine

class CharacterViewModel: ObservableObject {
    var characterURL: URL
    @Published var character: Character? = nil
    
    init(_ characterURL: URL) {
        self.characterURL = characterURL
        self.fetchCharacterInfo()
    }
    
    func fetchCharacterInfo() {
        let session = URLSession(configuration: .default)
        session.dataTask(with: characterURL) { [weak self] data, _, error in
            if let error = error {
                logged(type: .error, message: error.localizedDescription, fileName: "CharacterViewModel", method: "fetchCharacterInfo()")
            }
            guard let APIData = data else {
                logged(type: .noData, message: "No Data", fileName: "CharacterViewModel", method: "fetchCharacterInfo()")
                return
            }
            do {
                let characterData = try JSONDecoder().decode(Character.self, from: APIData)
                DispatchQueue.main.async {
                    self?.character = characterData
                }
                
            } catch let error {
                logged(type: .error, message: error.localizedDescription, fileName: "CharacterViewModel", method: "fetchCharacterInfo()")
            }
        }
        .resume()
    }
}
