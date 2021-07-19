//
//  DataModel.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 18.07.2021.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let data: [DataAnime]
}

// MARK: - DataAnime
struct DataAnime: Codable {
    let id, type: String
    let attributes: Attributes

}

// MARK: - Attributes
struct Attributes: Codable {
    let synopsis: String
    let titles: Titles

    enum CodingKeys: String, CodingKey {
        case synopsis
        case titles
    }
}



// MARK: - Titles
struct Titles: Codable {
    let en, enJp, jaJp: String

    enum CodingKeys: String, CodingKey {
        case en
        case enJp = "en_jp"
        case jaJp = "ja_jp"
    }
}
