//
//  CoreDataStack.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 19.07.2021.
//

import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnimeList")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("\(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func setAnimeList(content: [CurrentDataAnime]) {
        let context = persistentContainer.viewContext
        let oldList = fetchAnimeList()
        
        if !oldList.isEmpty {
            updateAnimeList(context: context, oldList: oldList, content: content)
        } else {
            addAnimeList(content: content)
        }
    }
    
    func fetchAnimeList() -> [CurrentDataAnime] {
        let request: NSFetchRequest<Anime> = Anime.fetchRequest()
        do {
            let listFromCoreData = try viewContext.fetch(request)
            var animeList: [CurrentDataAnime] = []
            animeList = listFromCoreData.compactMap({
                $0.convertToCurrnetAnime()
            })
            return animeList
            
        } catch {
            fatalError("Данные получить не удалось")
        }
    }
    
    private func addAnimeList(content: [CurrentDataAnime]) {
        let context = persistentContainer.newBackgroundContext()
        
        context.perform {
            for anime in content {
                let newAnime = Anime(context: context)
                newAnime.enTitle = anime.enTitle
                newAnime.enJpTitle = anime.enJpTitle
                newAnime.jpTitle = anime.jpTitle
                newAnime.synopsis = anime.synopsis
                self.save(context: context)
            }
        }
    }
    
    private func updateAnimeList(context: NSManagedObjectContext, oldList: [CurrentDataAnime], content: [CurrentDataAnime]) {
 
        if oldList == content {
            return
        } else {
            let request: NSFetchRequest<Anime> = Anime.fetchRequest()
            context.perform {
                do {
                    let result = try context.fetch(request)
                    for anime in result {
                        for newAnime in content {
                            anime.setValue(newAnime.enTitle, forKey: #keyPath(Anime.enTitle))
                            anime.setValue(newAnime.jpTitle, forKey: #keyPath(Anime.jpTitle))
                            anime.setValue(newAnime.enJpTitle, forKey: #keyPath(Anime.enJpTitle))
                            anime.setValue(newAnime.synopsis, forKey: #keyPath(Anime.synopsis))
                        }
                    }
                } catch let error as NSError {
                    print("\(error.userInfo)")
                }
                
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Сохрнаить данные не удалось \(error.userInfo)")
                }
            }
        }
        
    }
    
    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
}
