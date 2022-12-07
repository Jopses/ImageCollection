//
//  ImageScreenViewController.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

final class ImageScreenViewController: UIViewController, PropsConsumer {

    // MARK: - Properties
    
    private let collectionAdapter: ImageScreenCollectionAdapter
    
    private let flowLayout = with(UICollectionViewFlowLayout()) {
        $0.apply(.primary)
    }
    
    private lazy var collectionView = with(UICollectionView(frame: .zero, collectionViewLayout: flowLayout)) {
        $0.apply(.primary)
        $0.delegate = collectionAdapter
        $0.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.className)
    }

    private let refreshControl = with(UIRefreshControl()) {
        $0.apply(.primary)
    }
    
    internal var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    init(collectionAdapter: ImageScreenCollectionAdapter) {
        self.collectionAdapter = collectionAdapter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        makeConstraints()
        
        collectionAdapter.makeDiffableDataSource(collectionView)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(needToRefresh), for: .valueChanged)
        
        props.onNeedLoad.execute()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Prepare View

    private func prepareView() {
        view.apply(.backgroundColor)
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    
    // MARK: - Render
    private func render(oldProps: Props, newProps: Props) {
        refreshControl.endRefreshing()
        
        if oldProps.items != newProps.items {
            collectionAdapter.items = newProps.items
        }

    }

    // MARK: - Actions
    
    @objc private func needToRefresh() {
        props.onNeedRefresh.execute()
    }
}

// MARK: - Props

extension ImageScreenViewController {
    struct Props: Mutable, Equatable {
        var items: [ImageCellViewModel]
        var onNeedLoad: Command
        var onNeedRefresh: Command
        
        static var `default` = Props(items: [], onNeedLoad: .empty, onNeedRefresh: .empty)
        
        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.items == rhs.items
        }
    }
}
