//
//  NetworkService.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 18.07.2021.
//

import Foundation

struct NetworkService {
    
    private let sharedSession = URLSession.shared
    
    func fetchAnimeList(completion: @escaping (Result<[CurrentDataAnime], Error>) -> Void)  {
        guard let url = URL(string: "https://kitsu.io/api/edge/anime?page[limit]=5") else {
            return
        }
        let task = sharedSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("Нет данных!")
                return
            }
            
            if let animeDataList = parse(withData: data) {
                completion(.success(animeDataList))
            }
            
        }
        task.resume()
    }
    
    private func parse(withData data: Data) -> [CurrentDataAnime]? {
        do {
            let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
            var currentAnimeDataList: [CurrentDataAnime] = []
            
            for dataAnime in dataModel.data {
                guard let currentAnimeData = CurrentDataAnime(dataAnime: dataAnime) else {
                    return nil
                }
                currentAnimeDataList.append(currentAnimeData)
            }
            
            return currentAnimeDataList

        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    

}
