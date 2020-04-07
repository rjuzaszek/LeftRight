//
//  SwipeCardsViewModel.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 02/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SwipeCardsViewModel: SwipeCardsViewModelProtocol {
    
    //MARK: - Public properties
    
    //MARK: - Private properties
    
    private let categories: [Category]
    
    
    //MARK: - Initializers
    
    init(categories: [Category]) {
        self.categories = categories
    }
    
    //MARK: - Public interface
    
    func getNextCard(completion: @escaping (SwipeCardModel) -> Void) {
        let index = Int.random(in: 0..<categories.count)
        let getPictureStrategy = GetPictureUrlStrategyFactory.make(type: categories[index].method, parameters: categories[index].parameters)
        getPictureStrategy.getPicutreUrl(from: categories[index].url, completion: {
            completion(SwipeCardModel(photoUrl: $0))
        })
    }
    
    func getNextDirection() -> SwipeCards.Direction {
        return Bool.random() ? .left : .right
    }
}
