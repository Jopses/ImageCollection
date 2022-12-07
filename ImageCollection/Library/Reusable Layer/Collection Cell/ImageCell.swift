//
//  ImageCell.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

class ImageCell: PreparableCollectionCell {
    // MARK: - Properties

    private let randomImage = with(PrepareImageView(image: nil)) {
        $0.apply(.corner(4.0))
    }

    var props: Props = .default {
        didSet { render(oldProps: oldValue, newProps: props) }
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        props = .default
        randomImage.image = nil
    }
    
    override func prepare(withViewModel viewModel: PreparableViewModel?) {
        guard let model = viewModel as? ImageCellViewModel else {
            return
        }
        self.props = model.props
    }

    // MARK: - Prepare View

    private func prepareViews() {
        contentView.addSubview(randomImage)
        makeConstraints()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickAction))
        addGestureRecognizer(gesture)
    }

    private func makeConstraints() {
        randomImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            randomImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            randomImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            randomImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            randomImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Render

    private func render(oldProps: Props, newProps: Props) {
        randomImage.imageLoaderService = newProps.imageLoader
    }
    
    // MARK: - Actions
    
    @objc private func clickAction() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.transform.tx = self.contentView.bounds.width + 20
            self.alpha = 0.0
        } completion: { _ in
            guard let image = self.props.image else { return }
            self.props.onClick.execute(with: image)
        }
    }
}

// MARK: - Props

extension ImageCell {
    struct Props: Mutable, Hashable {
        var image: ImageDataModel?
        var imageLoader: ImageLoaderService?
        var onClick: CommandWith<ImageDataModel>

        static let `default` = Props(image: nil, imageLoader: nil, onClick: .empty)
        
        static func == (lhs: Props, rhs: Props) -> Bool {
            lhs.image == rhs.image
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(image?.id)
        }
    }
}
