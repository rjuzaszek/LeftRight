//
//  WrongAnswerAnimation.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 07/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class WrongAnswerAnimation {
    class func animate(_ view: UIView) {
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        UIView.animate(withDuration: 0.1, animations: {
            view.layer.backgroundColor = UIColor.red.withAlphaComponent(0.7).cgColor
            view.subviews.first?.alpha = 0.7
        }, completion: { _ in
            UIView.animate(withDuration: 0.4, animations: {
                view.layer.backgroundColor = UIColor.clear.cgColor
                view.subviews.first?.alpha = 1.0
            }, completion: { _ in
                view.layer.cornerRadius = 15
                view.clipsToBounds = true
            })
        })
    }
}
