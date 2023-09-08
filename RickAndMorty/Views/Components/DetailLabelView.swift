//
//  DetailLabelView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI

struct DetailLabelView: View {
    var key: String
    var value: String?
    
    var body: some View {
        HStack(alignment: .bottom){
            Text("\(key):")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
            Text(value ?? "Not Available")
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
        }
        .padding(.bottom, 4)
    }
}

struct DetailLabelView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLabelView(key: "Status:", value: "Alive")
    }
}
