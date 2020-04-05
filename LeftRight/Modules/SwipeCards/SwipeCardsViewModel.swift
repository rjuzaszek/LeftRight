//
//  SwipeCardsViewModel.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 02/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

class SwipeCardsViewModel: SwipeCardsViewModelProtocol {
    
    var photosUrls: [String]
    
    init(photosUrls: [String]) {
        self.photosUrls = photosUrls
    }
    
    func getNextCard() -> SwipeCardModel {
        let index = Int.random(in: 0..<photosUrls.count)
        let model = SwipeCardModel(photoUrl: photosUrls[index])
        return model
    }
    
    func getNextDirection() -> SwipeCards.Direction {
        return Bool.random() ? .left : .right
    }
}
