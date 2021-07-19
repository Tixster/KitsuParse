//
//  CurrentDataAnime.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 19.07.2021.
//

import Foundation

class CurrentDataAnime {

    let enTitle: String
    let enJpTitle: String
    let jpTitle: String
    let synopsis: String
    
    init?(dataAnime: DataAnime) {
        enTitle = dataAnime.attributes.titles.en
        enJpTitle = dataAnime.attributes.titles.enJp
        jpTitle = dataAnime.attributes.titles.jaJp
        synopsis = dataAnime.attributes.synopsis
    }
    
    init?(en: String, enJp: String, jp: String, synopsis: String) {
        self.enTitle = en
        self.enJpTitle = enJp
        self.jpTitle = jp
        self.synopsis = synopsis
    }
}

extension CurrentDataAnime: Equatable {
    static func == (lhs: CurrentDataAnime, rhs: CurrentDataAnime) -> Bool {
        return true
    }
}
