//
//  Localized.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

final class Localized: NSObject {
    fileprivate override init() {}
}

// MARK: - Base

extension Localized {
    static var error: String {
        return NSLocalizedString("Error", comment: "Base")
    }
    static var ok: String {
        return NSLocalizedString("Ok", comment: "Base")
    }
    static var cancel: String {
        return NSLocalizedString("Cancel", comment: "Base")
    }
    static var done: String {
        return NSLocalizedString("Done", comment: "Base")
    }
}
