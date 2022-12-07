//
//  ImageLoaderService.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import UIKit

protocol ImageLoaderService: AnyObject {
    func run(_ completion: @escaping (UIImage?) -> Void)
}

final class ImageLoaderServiceImp {
    
    private let objectId: String
    private let cache: CacheService
    
    init(objectId: String, cache: CacheService) {
        self.objectId = objectId
        self.cache = cache
    }
    
    private func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: objectId) else {
            completion(nil)
            return
        }

        getData(from: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data, error == nil else {
                completion(nil)
                return
            }
            self.cache.add(with: self.objectId, object: data)
            completion(UIImage(data: data))
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension ImageLoaderServiceImp: ImageLoaderService {
    func run(_ completion: @escaping (UIImage?) -> Void) {
        if let imageData: UIImage = cache.object(for: objectId) {
            completion(imageData)
            return
        }
        loadImage(completion: completion)
    }
}
