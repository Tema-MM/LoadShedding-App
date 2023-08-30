//
//  NetworkManager.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/13.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURLString = "https://developer.sepush.co.za/business/2.0"
    let apiToken = "A9A698BC-75454458-ADAFE42B-15AC0578"
    let timeout = 30.0
    
    func getStatus(completion: @escaping (Status?, Error?) -> ()) {
        let urlString = baseURLString + "/status"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Local", code: -1))
            
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["token" : apiToken]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      error == nil else {
                    completion(nil, error)
                    
                    return
                }
                
                do {
                    let status = try JSONDecoder().decode(Status.self, from: data)
                    completion(status, nil)
                } catch {
                    print(error.localizedDescription)
                    print(error)
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func getAreas(searchText: String, completion: @escaping (AreasSearch?, Error?) -> ()) {
        let urlString = "https://developer.sepush.co.za/business/2.0/areas_search?text=\(searchText)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Local", code: -1))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["token": apiToken]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data =  data,
                      error ==  nil else{
                    completion(nil, error)
                    return
                }
                
                do{
                    let areaSearch = try JSONDecoder().decode(AreasSearch.self, from: data)
                    completion(areaSearch, nil)
                }catch{
                    print(error)
                }

            }
        }
        
        task.resume()
    }
    
    func MockAreas(completion: @escaping (AreasSearch?, Error?) -> ()) {
        let result = Bundle.main.decode(AreasSearch.self, from: "MockSearch.json")
        completion(result, nil)
    }
    
    func getAreaDetail(id: String, test: String? = nil, completion: @escaping (Area?, Error?) -> ()) {
        
        var urlString = "https://developer.sepush.co.za/business/2.0"
        urlString = urlString + "/area?id=\(id)"
        
        if let test =  test {
            urlString = urlString + "/area?id=\(test)"
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Local", code: -1))
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["token": apiToken]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data =  data,
                      error ==  nil else{
                    completion(nil, error)
                    
                    return
                }
                
                do{
                    let areaSearch = try JSONDecoder().decode(Area.self, from: data)
                    completion(areaSearch, nil)
                }catch{
                    print(error.localizedDescription)
                    print(error)
                    completion(nil, error)
                }
            }
            
        }
        
        task.resume()
    }
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}








