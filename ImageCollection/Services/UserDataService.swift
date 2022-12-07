//
//  UserDataService.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

final class UserDataService {
    
    enum Keys: String {
        case imageUrlList
    }
    
    private let defult = UserDefaults.standard
    
    func setObject<T: Hashable>(_ data: T, key: Keys) {
        defult.set(data, forKey: key.rawValue)
    }
    
    func getObject<T: Hashable>(key: Keys) -> T? {
        defult.object(forKey: key.rawValue) as? T
    }
    
    func setData<T: Codable>(_ data: T, key: Keys) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            defult.set(encoded, forKey: key.rawValue)
        }
    }

    func getData<T: Codable>(key: Keys) -> T? {
        guard let list = defult.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        if let loaded = try? decoder.decode(T.self, from: list) {
            return loaded
        }
        return nil
    }

    func clearObject(key: Keys) {
        defult.removeObject(forKey: key.rawValue)
    }
}
