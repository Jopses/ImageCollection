//
//  PrepareImageView.swift
//  ImageCollection
//
//  Created by Pavel Zorin on 06.12.2022.
//

import UIKit

final class PrepareImageView: UIImageView {
    // MARK: - Properties
    
    private let activityIndicator = with(UIActivityIndicatorView(style: .medium)) {
        $0.apply(.primary)
    }

    private let errorLabel = with(UILabel()) {
        $0.apply([.errorColor, .header6, .alignCenter])
        $0.text = Localized.error
    }
    
    weak var imageLoaderService: ImageLoaderService? {
        didSet {
            setImage()
        }
    }
    
    override var image: UIImage? {
        didSet {
            if image != nil {
                errorLabel.removeFromSuperview()
                activityIndicator.removeFromSuperview()
            }
        }
    }

    // MARK: - Lifecycle

    override init(image: UIImage?) {
        super.init(image: image)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Prepare View

    private func setActivityIndicator() {
        errorLabel.removeFromSuperview()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Private method

    private func setImage() {
        setActivityIndicator()
        imageLoaderService?.run { [weak self] image in
            DispatchQueue.main.async {
                if image == nil {
                    self?.activityIndicator.removeFromSuperview()
                    self?.setErrorLabel()
                    return
                }
                self?.image = image
            }
        }
    }
}


