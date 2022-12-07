//
//  UIActivityIndicatorViewStylable.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

extension StyleWrapper where Element == UIActivityIndicatorView {
    static var primary: StyleWrapper {
        return .wrap { view, theme in
            view.color = theme.colorPalette.onSecondary
        }
    }
}
