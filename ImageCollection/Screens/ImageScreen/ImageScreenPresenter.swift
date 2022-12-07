//
//  ImageScreenPresenter.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

final class ImageScreenPresenter: PropsProducer {
    typealias Props = ImageScreenViewController.Props
    
    var propsRelay: Observable<Props> = Observable(.default)

    // MARK: - Properties

    private let service: ImageScreenServiceProvider
    private let cache = CacheService(cacheName: "ImageCollection")
    
    private var itemsImage: [ImageDataModel] = [] {
        didSet {
            propsRelay.value = propsRelay.mutate {
                $0.items = self.mapModelForCell()
            }
        }
    }

    // MARK: - Lifecycle

    init(service: ImageScreenServiceProvider) {
        self.service = service
        
        propsRelay.value = propsRelay.mutate {
            $0.onNeedLoad = Command { [weak self] in
                guard let self = self else { return }
                self.itemsImage = self.service.getOldImagesUrlList ?? self.service.getNewImagesUrlList
            }
            $0.onNeedRefresh = Command { [weak self] in
                guard let self = self else { return }
                self.service.clearImagesUrlList()
                self.clearCache()
                self.itemsImage = self.service.getNewImagesUrlList
            }
        }
    }
    
    // MARK: - Private Methods

    private func mapModelForCell() -> [ImageCellViewModel] {
        itemsImage.map {
            ImageCellViewModel(
                props: ImageCell.Props(
                    image: $0,
                    imageLoader: ImageLoaderServiceImp(objectId: $0.urlString, cache: cache),
                    onClick: CommandWith<ImageDataModel> { [weak self] image in
                        guard let self = self else { return }
                        self.itemsImage = self.itemsImage.filter { $0 != image }
                    }
                )
            )
        }
    }

    private func clearCache() {
        itemsImage.forEach {
            cache.remove(by: $0.urlString)
        }
    }
}
