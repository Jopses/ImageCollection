//
//  Cache.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

class Cache: NSObject {

    public let name: String

    let frontStorage: CacheAware
    let backStorage: CacheAware
    
    init(name: String, maxMemorySize: UInt = 0, maxDiskSize: UInt = 0) {
        self.name = name
        
        frontStorage = MemoryStorage(name: name, maxSize: maxMemorySize)
        backStorage = with(DiskStorage(name: name, maxSize: maxDiskSize)) {
            $0.cleanupIfNeeded()
        }
        super.init()
    }
    
    func add<T: Cachable>(with key: String, object: T) {
        frontStorage.add(with: key, object: object)
        backStorage.add(with: key, object: object)
    }
    
    func object<T: Cachable>(for key: String) -> T? {
        let object = frontStorage.object(for: key) as T?
        if let object = object {
            return object
        }
        
        let diskObj = backStorage.object(for: key) as T?
        if let obj = diskObj {
            frontStorage.add(with: key, object: obj)
        }
        return diskObj
    }

    func remove(by key: String) {
        frontStorage.remove(by: key)
        backStorage.remove(by: key)
    }
    
    func clear() {
        frontStorage.clear()
        backStorage.clear()
    }
}

