//
//  SwipeCardsGameComponentsFactory.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 03/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

struct SwipeCardsComponentsFactory {
    
    static func makeDirectionLabel() -> UILabel {
        let directionLabel = UILabel()
        directionLabel.translatesAutoresizingMaskIntoConstraints = false
        directionLabel.text = ""
        directionLabel.font = UIFont.systemFont(ofSize: 32.0)
        directionLabel.textColor = .systemPink
        return directionLabel
    }
    
    static func makeCardsContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        return container
    }
    
    static func makeScoreLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 60.0)
        label.text = "0"
        label.textColor = .systemPink
        return label
    }
}
