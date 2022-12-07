//
//  ImageCellViewModel.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

class ImageCellViewModel: PreparableViewModel, Hashable {
    let cellId: String = ImageCell.className
    let props: ImageCell.Props

    init(props: ImageCell.Props) {
        self.props = props
    }

    static func == (lhs: ImageCellViewModel, rhs: ImageCellViewModel) -> Bool {
        lhs.props == rhs.props
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(props.image?.id)
    }
}
