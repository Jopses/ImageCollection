//
//  UICollectionViewStylable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

extension StyleWrapper where Element == UICollectionView {
    static var primary: StyleWrapper {
        return .wrap { collection, theme in
            collection.backgroundColor = theme.colorPalette.background
            collection.showsVerticalScrollIndicator = false
            collection.contentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        }
    }
}
