//
//  LocationViewModel.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import Foundation
import SwiftUI
import Combine

class LocationViewModel: ObservableObject {
    var locationURL: URL
    @Published var residents: [Character]? = nil
    @Published var loadingState: LoadingState = .none
    @Published var locationData: LocationResponse? = nil
    
    init(locationURL: URL) {
        self.locationURL = locationURL
        self.fetchLocationInfo()
    }
    
    func fetchLocationInfo() {
        let session = URLSession(configuration: .default)
        self.loadingState = .location
        session.dataTask(with: locationURL) { [weak self] data, _, error in
            if let error = error {
                self?.loadingState = .failure
                self?.dismissAnimation()
                logged(type: .error, message: error.localizedDescription, fileName: "LocationViewModel", method: "fetchLocationInfo()")
            }
            guard let APIData = data else {
                logged(type: .noData, message: "No Data", fileName: "LocationViewModel", method: "fetchLocationInfo()")
                self?.loadingState = .failure
                self?.dismissAnimation()
                return
            }
            do {
                let locationData = try JSONDecoder().decode(LocationResponse.self, from: APIData)
                DispatchQueue.main.async {
                    self?.loadingState = .success
                    self?.locationData = locationData
                    self?.dismissAnimation()
                }
                
            } catch let error {
                logged(type: .error, message: error.localizedDescription, fileName: "LocationViewModel", method: "fetchLocationInfo()")
                self?.loadingState = .failure
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

