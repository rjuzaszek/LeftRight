//
//  UIView+insertWithConstraints.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 07/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithConstraints(_ view: UIView) {
        addSubview(view)
        setupFillingConstraints(view)
    }
    
    func insertSubviewWithConstraints(_ view: UIView, index: Int) {
        insertSubview(view, at: index)
        setupFillingConstraints(view)
    }
    
    func setupFillingConstraints(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
