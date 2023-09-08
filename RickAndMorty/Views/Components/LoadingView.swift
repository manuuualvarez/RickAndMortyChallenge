//
//  LoadingView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI

struct LoadingView: View {
    let loadingState: LoadingState
    var body: some View {
        switch loadingState {
        case .none:
            EmptyView()
        case .loading:
            LottieView(filename: "loading")
        case .success:
            LottieView(filename: "success")
                .background(Color.clear.opacity(0))
        case .failure:
            LottieView(filename: "error")
        case .location:
            LottieView(filename: "location")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingState: .loading)
    }
}
