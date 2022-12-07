//
//  UIViewStylable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

extension StyleWrapper where Element == UIView {
    static func corner(_ radius: CGFloat) -> StyleWrapper {
        .wrap { view, theme in
            view.layer.cornerRadius = radius
        }
    }
}
