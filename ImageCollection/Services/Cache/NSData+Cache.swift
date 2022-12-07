//
//  NSData+Cache.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

extension Data: Cachable {
    
    public static func decode(_ data: Data) -> Data? {
        return data
    }
    
    public func encode() -> Data? {
        return self
    }
}
