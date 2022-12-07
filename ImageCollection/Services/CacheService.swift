//
//  CacheService.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

final class CacheService: Cache {
    
    private let maxMemorySize: UInt = 120 * 1024 * 1024
    private let maxDiskSize: UInt = 150 * 1024 * 1024
    
    init(cacheName: String) {
        super.init(name: cacheName, maxMemorySize: maxMemorySize, maxDiskSize: maxDiskSize)
    }
}
