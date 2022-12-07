//
//  ImageScreenServiceProvider.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

protocol ImageScreenServiceProvider: AnyObject {
    var getOldImagesUrlList: [ImageDataModel]? { get }
    var getNewImagesUrlList: [ImageDataModel] { get }
    
    func clearImagesUrlList()
}

final class ImageScreenServiceProviderImp {

    // MARK: - Properties
    
    private let userDataService = UserDataService()

    // MARK: - Lifecycle

    init() { }
}

// MARK: - ChannelsInteractorInput

extension ImageScreenServiceProviderImp: ImageScreenServiceProvider {
    
    var getOldImagesUrlList: [ImageDataModel]? {
        return userDataService.getData(key: .imageUrlList)
    }

    var getNewImagesUrlList: [ImageDataModel] {
        let model = (1...6).map( {_ in .random(in: 0...1000)} ).map {
            ImageDataModel(
                id: $0,
                urlString: AppDefaults.imageUrl(number: $0)
            )
        }
        userDataService.setData(model, key: .imageUrlList)
        return model
    }

    func clearImagesUrlList() {
        userDataService.clearObject(key: .imageUrlList)
    }
}

