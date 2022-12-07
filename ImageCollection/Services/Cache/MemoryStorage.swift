//
//  MemoryStorage.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

private let prefix = "InMemoryCache"

final class MemoryStorage: CacheAware {
    private var maxSize: UInt
    
    private let cache = NSCache<AnyObject, AnyObject>()
    
    required init(name: String, maxSize: UInt = 0) {
        self.maxSize = maxSize
        
        cache.countLimit = Int(maxSize)
        cache.totalCostLimit = Int(maxSize)
        cache.name = "\(prefix).\(name.capitalized)"
    }
    
    func add<T: Cachable>(with key: String, object: T) {
        cache.setObject(object as AnyObject, forKey: key as AnyObject)
    }
    
    func object<T: Cachable>(for key: String) -> T? {
        return cache.object(forKey: key as AnyObject) as? T
    }
    
    func remove(by key: String) {
        cache.removeObject(forKey: key as AnyObject)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}

