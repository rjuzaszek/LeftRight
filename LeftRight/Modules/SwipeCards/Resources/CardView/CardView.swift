//
//  CardView.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 01/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    //MARK: - Public properties
    
    var shouldRotateLeft = false
    
    //MARK: - Private properties
    
    //MARK: - Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    //MARK: - Public functions
    
    func setup(model: SwipeCardModel) {
        removeAllSubviews()
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        ImageDownloader.download(from: model.photoUrl, completion: { [weak self] image in
            imageView.image = image
            self?.setCardShadow()
        })
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        setImageViewConstraints(imageView)
    }
}

//MARK: - Private functions
private extension CardView {
    
    func removeAllSubviews() {
        subviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
    func setImageViewConstraints(_ imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
