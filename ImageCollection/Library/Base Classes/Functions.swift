//
//  Functions.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

func with<T>(_ object: T, _ initializer: (T)->Void) -> T {
    initializer(object)
    return object
}
