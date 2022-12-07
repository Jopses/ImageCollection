//
//  ImageScreenAdapter.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

final class ImageScreenCollectionAdapter: NSObject {

    // MARK: - Properties
    
    private enum Section: Hashable {
        case main
    }
    
    private var diffableDataSource:UICollectionViewDiffableDataSource<Section, ImageCellViewModel>?

    var items: [ImageCellViewModel] = [] {
        didSet {
            updateSnapshot()
        }
    }

    // MARK: - Public Methods
    
    func makeDiffableDataSource(_ collection: UICollectionView) {
        diffableDataSource = UICollectionViewDiffableDataSource<Section, ImageCellViewModel>(collectionView: collection) {
            collectionView, indexPath, viewModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellId, for: indexPath)
            if let reusableCell = cell as? PreparableCollectionCell {
                reusableCell.prepare(withViewModel: viewModel)
            }
            return cell
        }
        updateSnapshot()
    }

    // MARK: - Private Methods

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageCellViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageScreenCollectionAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newSize = collectionView.frame.width - 20.0
        return CGSize(width: newSize, height: newSize)
    }
}
