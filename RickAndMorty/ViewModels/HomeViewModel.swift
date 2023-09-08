//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var characters: [Character]? = nil
    @Published var loadingState: LoadingState = .none
    private var infoResponse: Info? = nil
    
    func fetchCharacters() {
        var urlStr = "https://rickandmortyapi.com/api/character"
        if infoResponse?.next != nil && characters != nil {
            urlStr = infoResponse!.next!
        }
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlStr) else {
            return
        }
        self.loadingState = .loading
        session.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.loadingState = .none
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.loadingState = .failure
                }
                self?.dismissAnimation()
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "fetchCharacters()")
            }
            guard let APIData = data else {
                logged(type: .noData, message: "No Data", fileName: "HomeViewModel", method: "fetchCharacters()")
                DispatchQueue.main.async {
                    self?.loadingState = .failure
                }
                self?.dismissAnimation()
                return
            }
            do {
                let charactersData = try JSONDecoder().decode(RickAndMortyResponse.self, from: APIData)
                self?.infoResponse = charactersData.info
                DispatchQueue.main.async {
                    if self?.characters == nil {
                        self?.characters = charactersData.results
                    } else {
                        self?.characters?.append(contentsOf: charactersData.results)
                    }
                }
                self?.dismissAnimation()
            } catch let error {
                logged(type: .error, message: error.localizedDescription, fileName: "HomeViewModel", method: "fetchCharacters()")
                DispatchQueue.main.async {
                    self?.loadingState = .failure
                }
                self?.dismissAnimation()

            }
        }
        .resume()
    }
    
    private func dismissAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingState = .none
        }
    }
}

