//
//  NSObject+className.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
