//
//  FileManager+Cache.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

extension FileManager {
    func allocatedSizeOfDirectory(at directoryURL: URL) throws -> UInt64 {
        
        let enumerator = try allocatedDirectory(at: directoryURL)
        var accumulatedSize: UInt64 = 0
        
        for item in enumerator {
            let contentItemURL = item as! URL
            accumulatedSize += try contentItemURL.regularFileAllocatedSize()
        }
        
        return accumulatedSize
    }

    func filesNameBySizeLimit(at directoryURL: URL, by limit: UInt64) throws -> [URL] {
        let enumerator = try allocatedDirectory(at: directoryURL)
        var accumulatedSize: UInt64 = 0
        var filesName: [URL] = []
        
        let enumeratorSort = try enumerator.sorted {
            
            let values1 = try ($0 as AnyObject).resourceValues(forKeys: [.creationDateKey])
            let values2 = try ($1 as AnyObject).resourceValues(forKeys: [.creationDateKey])
            
            if let date1 = values1.first?.value as? Date, let date2 = values2.first?.value as? Date {
                return date1.compare(date2) == .orderedAscending
            }
            return true
        }
        
        for item in enumeratorSort {
            if accumulatedSize >= limit { break }
            
            let contentItemURL = item as! URL
            accumulatedSize += try contentItemURL.regularFileAllocatedSize()
            filesName.append(contentItemURL)
        }
        return filesName
    }

    private func allocatedDirectory(at directoryURL: URL) throws -> DirectoryEnumerator {

        var enumeratorError: Error? = nil
        func errorHandler(_: URL, error: Error) -> Bool {
            enumeratorError = error
            return false
        }

        let enumerator =  self.enumerator(at: directoryURL,
                                         includingPropertiesForKeys: Array(allocatedSizeResourceKeys),
                                         options: [],
                                         errorHandler: errorHandler)!
        
        if let error = enumeratorError { throw error }
        
        return enumerator
    }
}

fileprivate let allocatedSizeResourceKeys: Set<URLResourceKey> = [
    .isRegularFileKey,
    .fileAllocatedSizeKey,
    .totalFileAllocatedSizeKey,
]

fileprivate extension URL {

    func regularFileAllocatedSize() throws -> UInt64 {
        let resourceValues = try self.resourceValues(forKeys: allocatedSizeResourceKeys)

        guard resourceValues.isRegularFile ?? false else {
            return 0
        }

        return UInt64(resourceValues.totalFileAllocatedSize ?? resourceValues.fileAllocatedSize ?? 0)
    }
}

