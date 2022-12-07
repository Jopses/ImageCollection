//
//  String+Cache.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 07.12.2022.
//

import Foundation

extension String {
    func base64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else { return self }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
}
