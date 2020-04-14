//
//  UIView+shadow.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 14/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

extension UIView {
    func setCardShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
    }
}
