//
//  CacheAware.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

protocol CacheAware {
    func add<T: Cachable>(with key: String, object: T)
    func object<T: Cachable>(for key: String) -> T?
    func remove(by key: String)
    func clear()
}
