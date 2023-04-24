//
//  ReadData.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 23/04/2023.
//

import Foundation

protocol DeviceConfigProtocol {
    func deviceConfigChanged(_ device: Device)
}

final class readData {
    
    public func loadJson(fromURLString urlString: String,
                         completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    public func parse(jsonData: Data) -> UserData? {
        do {
            let decodedData = try JSONDecoder().decode(UserData.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
            
            return nil
        }
    }
}
