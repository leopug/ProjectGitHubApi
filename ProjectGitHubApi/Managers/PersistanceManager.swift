//
//  PersistanceManager.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 25/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistanceManager {
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private let defaults = UserDefaults.standard
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower],GHAErrorMessage>) -> Void) {
        
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
    
    static func updateFavoriteListWith(favorite: Follower, actionType: PersistanceActionType, completed: @escaping (GHAErrorMessage?)->Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
        
    }
    
    static func save(favorites: [Follower]) -> GHAErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
