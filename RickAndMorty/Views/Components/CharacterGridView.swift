//
//  CharacterGridView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI

struct CharacterGridView: View {
    var residents: [String]
    private let adapColums = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adapColums, spacing: 15) {
                ForEach(residents, id: \.self) { urlStr in
                    CharacterItemView(characterUrl: URL(string: urlStr)!)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CharacterGridView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterGridView(residents: lasLocationMock.residents!)
    }
}
