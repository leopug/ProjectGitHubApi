import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    var followersUrlBuilder = { (username:String) -> URLComponents in
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/users/\(username)/followers"
        return components
    }
    
    private init(){}
    
    func getFollowers(for username: String,
                      page: Int,
                      completed: @escaping (Result<[Follower], GHAErrorMessage>) -> Void ) {
        
        var endpoint = followersUrlBuilder(username)
        endpoint.queryItems = [
            URLQueryItem(name: "per_page", value: String(100)),
            URLQueryItem(name: "page", value: String(page))
        ]
        print(endpoint.url!.absoluteString)
        guard let url = URL(string: endpoint.url!.absoluteString) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String,
                     completed: @escaping (Result<User, GHAErrorMessage>) -> Void ) {
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?)-> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let `self` = self,
                error == nil ,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let donwloadImage = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(donwloadImage, forKey: cacheKey)
            completed(donwloadImage)
        }
        task.resume()
    }
    
}
