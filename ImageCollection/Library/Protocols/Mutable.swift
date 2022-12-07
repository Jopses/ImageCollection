//
//  Mutable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

protocol Mutable { }

extension Mutable {
    func mutate(mutation: (inout Self) -> ()) -> Self {
        var val = self
        mutation(&val)
        return val
    }
}

extension Observable where T: Mutable {
    func mutate(mutation: @escaping (inout T) -> ()) -> T {
        return value.mutate(mutation: mutation)
    }
}
