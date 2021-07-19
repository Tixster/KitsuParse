//
//  Anime+CoreDataProperties.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 19.07.2021.
//
//

import Foundation
import CoreData


extension Anime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Anime> {
        return NSFetchRequest<Anime>(entityName: "Anime")
    }

    @NSManaged public var enTitle: String
    @NSManaged public var enJpTitle: String
    @NSManaged public var jpTitle: String
    @NSManaged public var synopsis: String

}

extension Anime: Identifiable {
    
    func convertToCurrnetAnime() -> CurrentDataAnime? {
        return CurrentDataAnime(en: enTitle, enJp: enJpTitle, jp: jpTitle, synopsis: synopsis)
    }
    
}
