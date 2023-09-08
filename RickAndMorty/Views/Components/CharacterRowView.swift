//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var character: Character
    @State var isFavorite: Bool? = nil
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteCharacter.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<FavoriteCharacter>
    
    private func favButtonDidTapped() {
        guard let fav = isFavorite else {
            return
        }
        if fav {
            deleteCharacterItem()
        } else {
            persistCharacterItem()
        }
    }
    
    private func persistCharacterItem() {
        withAnimation {
            let newFav = FavoriteCharacter(context: viewContext)
            newFav.timestamp = Date()
            newFav.id = UUID()
            newFav.characterId = Int16(character.id)
            newFav.favorite = true
            newFav.name = character.name
            
            do {
                try viewContext.save()
                self.isFavorite!.toggle()
            } catch {
                let nsError = error as NSError
                logged(type: .error, message: nsError.localizedDescription, fileName: "CharacterRowView", method: "persistCharacterItem()")
                fatalError("unresolved error: \(nsError), \(nsError.userInfo)")
            }
            checkIsFavorite()
        }
    }
    
    private func deleteCharacterItem() {
        guard let item = self.items.filter({ $0.characterId == Int16(character.id) }).first else {
            return
        }
        withAnimation {
            viewContext.delete(item)
          do {
            try viewContext.save()
          } catch {
            let nsError = error as NSError
              logged(type: .error, message: nsError.localizedDescription, fileName: "CharacterRowView", method: "deleteCharacterItem()")
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
          }
        }
        checkIsFavorite()
    }
    
    private func checkIsFavorite() {
        isFavorite = self.items.contains { $0.characterId == Int16(character.id) }
    }
    
    var body: some View {
        if let _ = isFavorite {
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 15.0) {
                    if let url = URL(string: character.image ?? "") {
                        WebImage(url: url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150)
                            .cornerRadius(8)
                    }
                    VStack(alignment: .leading, spacing: 8.0) {
                        HStack {
                            Text(character.name)
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Button {
                                self.favButtonDidTapped()
                            } label: {
                                Image(systemName: isFavorite! ? "star.fill" : "star.slash")
                                    .foregroundColor(isFavorite! ? Color.pink : Color.gray)
                            }
                        }
//                        DetailLabelView(key: "Status", value: character.status)
//                        DetailLabelView(key: "Species", value: character.species)
//                        DetailLabelView(key: "Gender", value: character.gender)
//                        DetailLabelView(key: "Origin", value: character.origin?.name)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
                HStack {
                    NavigationLink {
                        if character.location == nil || character.location?.name == "unknown" {
//                            EmptyLocationView(name: character.name, image: character.image ?? "")
                        } else {
//                            LocationView(locationURL: URL(string: (character.location?.url)!)!)
                        }
                    } label: {
                        HStack {
//                            DetailLabelView(key: "Last Location", value: character.location?.name)
//                                .padding(.horizontal)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .fontWeight(.bold)
                                .padding(.horizontal)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        } else {
            ProgressView()
                .onAppear(perform: {
                    self.checkIsFavorite()
                })
        }
        
        
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: characterMock, isFavorite: false)
    }
}

