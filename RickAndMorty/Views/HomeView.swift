//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    // MARK: - CoreData
    @Environment(\.managedObjectContext) private var viewContext
    // MARK: - Properties
    @EnvironmentObject private var homeVM: HomeViewModel
    // MARK: - Body
    var body: some View {
        NavigationView {
            if homeVM.characters == nil || homeVM.loadingState != .none {
                LoadingView(loadingState: homeVM.loadingState)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(homeVM.characters!) { character in
                        CharacterRowView(character: character)
                    }
                    // Infiniy Scroll
                    GeometryReader { reader -> Color in
                        let minY = reader.frame(in: .global).minY
                        let heigth = UIScreen.main.bounds.height / 1.3
                        
                        if minY < heigth {
                            DispatchQueue.main.async {
                                homeVM.fetchCharacters()
                            }
                        }
                        return Color.clear
                    }
                }
                .navigationTitle("Rick & Morty")
            }
        }
        .onAppear(perform: {
            self.homeVM.fetchCharacters()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(HomeViewModel())
    }
}
