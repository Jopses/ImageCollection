//
//  UICollectionViewFlowLayoutStylable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

extension UICollectionViewFlowLayout: Stylable {}

extension StyleWrapper where Element == UICollectionViewFlowLayout {
    static var primary: StyleWrapper {
        return .wrap { layout, theme in
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            layout.sectionInset = .zero
        }
    }
}
