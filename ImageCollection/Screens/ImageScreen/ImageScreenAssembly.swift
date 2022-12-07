//
//  ImageScreenAssembly.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

final class ImageScreenAssembly {

    func assemble() -> UIViewController {
        let service = ImageScreenServiceProviderImp()
        let presenter = ImageScreenPresenter(service: service)
        let collectionAdapter = ImageScreenCollectionAdapter()
        let view = ImageScreenViewController(collectionAdapter: collectionAdapter)
        view.bind(to: presenter)

        return view
    }
}
