//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 18.09.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func update(favorite: Follower, actiontype: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retriveFavorites { (result) in
            switch result {
            case .success(let favorites):
                
                var retrivedFavorites = favorites
                
                switch actiontype {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrivedFavorites.append(favorite)
                    
                case .remove:
                    retrivedFavorites.removeAll { $0.login == favorite.login}
                }
                
                completed(saveFavorites(favorites: retrivedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retriveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))

        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func saveFavorites(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil // no GFError
        } catch {
            return .unableToFavorite
        }
    }
}
