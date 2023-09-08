//
//  APIResponse.swift
//  RickAndMorty
//
//  Created by Manny Alvarez on 07/09/2023.
//

import Foundation


struct RickAndMortyResponse: Codable {
    var info: Info?
    var results: [Character]
}

struct Info: Codable {
    var count: Int?
    var next: String?
    var pages: Int?
    var prev: String?
}

struct  Character: Codable, Identifiable {
    var created: String?
    var episode: [String]?
    var gender: String?
    var id: Int
    var image: String?
    var location: Location?
    var name: String
    var origin: Origin?
    var species: String?
    var status: String?
    var type: String?
    var url: String?
}

struct Location: Codable {
    var name: String?
    var url: String?
}

struct Origin: Codable {
    var name: String?
    var url: String?
}

import Foundation

struct LocationResponse: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}



