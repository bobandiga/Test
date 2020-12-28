//
//  BBManager.swift
//  DBManager
//
//  Created by Максим Шаптала on 28.12.2020.
//

import Foundation

public struct DBULiteManager<T: Codable> {
    
    private let userDefaults: UserDefaults
    
    public init(suitName: String) {
        userDefaults = UserDefaults(suiteName: suitName)!
    }
    
    public func save(entity: T, key: String) {
        guard let data = try? JSONEncoder().encode(entity) else { return }
        userDefaults.setValue(data, forKey: key)
    }
    
    public func receive(key: String, completion: (T?) -> ()) {
        guard let data = userDefaults.data(forKey: key) else { completion(nil); return }
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(T.self, from: data) else { completion(nil); return }
        completion(decodedData)
    }
}
