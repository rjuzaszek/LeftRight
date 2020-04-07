//
//  SwipeCardsInterface.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

struct SwipeCards {
    static let dismissVelocity = 200.0
    static let dismissPosition = 32.0
    
    enum Direction: String {
        case left = "LEFT"
        case right = "RIGHT"
    }
}

protocol SwipeCardsCoordination: class {
    func close()
}

protocol SwipeCardsViewModelProtocol {
    func getNextDirection() -> SwipeCards.Direction
    func getNextCard(completion: @escaping (SwipeCardModel) -> Void)
}

