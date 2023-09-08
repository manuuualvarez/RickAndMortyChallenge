//
//  CharacterItemView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterItemView: View {
    @ObservedObject var characterVM: CharacterViewModel
        
    init(characterUrl: URL) {
        self.characterVM = CharacterViewModel(characterUrl)
    }
    
    var body: some View {
        if let url = URL(string: characterVM.character?.image ?? "") {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 170)
                        .cornerRadius(8)
                    VStack(alignment: .leading) {
                        Text(characterVM.character?.name ?? "")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .shadow(radius: 15, x: 5, y: 5)
                            .padding(.bottom)
                            .padding(.leading, 4)
                    }
                    .shadow(color: Color.red ,radius: 5, x: 6, y: 6)
                }
            }
        } else {
            ZStack {
                Rectangle()
                    .frame(width: 170, height: 170)
                    .opacity(0.06)
                    .cornerRadius(8)
                
                ProgressView()
            }
        }

    }
        
}

struct CharacterItemView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItemView(characterUrl: URL(string: lasLocationMock.residents![0])!)
    }
}
