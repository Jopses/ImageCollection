//
//  ImageDataModel.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

struct ImageDataModel: Codable, Hashable {
    let id: Int
    let urlString: String
    
    static func == (lhs: ImageDataModel, rhs: ImageDataModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.urlString == rhs.urlString
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

