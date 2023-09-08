//
//  EmptyLocationView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmptyLocationView: View {
    var name: String
    var image: String
    var body: some View {
        VStack {
            Image(systemName: "location.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
                .cornerRadius(8)
                .foregroundColor(.pink)
            Text("No Last Location Data for:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
            Text(name)
                .foregroundColor(.pink)
                .fontWeight(.bold)
            if let url = URL(string: image) {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 50)
                    .cornerRadius(8)
            }
        }
    }
}

struct EmptyLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyLocationView(name: characterMock.name, image: characterMock.image ?? "")
    }
}
