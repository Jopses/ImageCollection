//
//  Cachable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

public protocol Cachable {
    associatedtype CacheType
    static func decode(_ data: Data) -> CacheType?
    func encode() -> Data?
}
