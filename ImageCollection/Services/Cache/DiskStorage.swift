//
//  DiskStorage.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

final class DiskStorage: CacheAware {
    private let path: String
    private var maxSize: UInt
    private let limitSizeStorage: UInt64
    
    
    private lazy var fileManager: FileManager = FileManager()
    
    required init(name: String, maxSize: UInt = 0) {
        self.maxSize = maxSize
        self.limitSizeStorage = UInt64(Float(self.maxSize) * 0.3)
        let cacheName = name.capitalized
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                        FileManager.SearchPathDomainMask.userDomainMask, true)
        
        path = String(format: "%@/%@", paths.first ?? "/Library/Caches", cacheName)
    }
    
    func add<T: Cachable>(with key: String, object: T) {
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
     
        let filePath = self.filePath(for: key)
        fileManager.createFile(atPath: filePath, contents: object.encode() as Data?, attributes: nil)
    }
    
    func object<T: Cachable>(for key: String) -> T? {
        let filePath = self.filePath(for: key)
        var cachedObject: T?
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            cachedObject = T.decode(data) as? T
        }
        
        return cachedObject
    }
    
    func remove(by key: String) {
        try? fileManager.removeItem(atPath: filePath(for: key))
    }
    
    func clear() {
        try? fileManager.removeItem(atPath: path)
    }

    func cleanupIfNeeded() {
        DispatchQueue.global().async {
            if let localSize = try? self.fileManager.allocatedSizeOfDirectory(at: URL(fileURLWithPath: self.path)),
                localSize >= self.maxSize {
                
                let limitList = try? self.fileManager.filesNameBySizeLimit(at: URL(fileURLWithPath: self.path),
                                                                           by: self.limitSizeStorage)
                limitList?.forEach {
                    try? self.fileManager.removeItem(at: $0)
                }
            }
        }
    }

    fileprivate func fileName(for key: String) -> String {
        return key.base64()
    }
    
    fileprivate func filePath(for key: String) -> String {
        return "\(path)/\(fileName(for: key))"
    }
}




