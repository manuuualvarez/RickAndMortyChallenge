//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var locationVM: LocationViewModel
    
    init(locationURL: URL) {
        self.locationVM = LocationViewModel(locationURL: locationURL)
    }
    
    var body: some View {
        VStack {
            Text(locationVM.locationData?.name ?? "No Name")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                VStack(alignment: .leading) {
                    DetailLabelView(key: "Type", value: locationVM.locationData?.type)
                    DetailLabelView(key: "Dimension", value: locationVM.locationData?.dimension)
                }
                Spacer()
            }
            .padding()

            Spacer()
            HStack {
                Text("Residents")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            Divider()
            CharacterGridView(residents: locationVM.locationData?.residents ?? [])
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(locationURL: URL(string: locationMock.url!)!)
    }
}

