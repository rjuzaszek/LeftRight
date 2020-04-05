//
//  CategoriesService.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 05/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

protocol CategoriesServiceProtocol {
    func getCategories(success: ([Category]) -> Void, failure: (Error?) -> Void)
}

class MockedCategories: CategoriesServiceProtocol {
    
    private let categories: [Category] = [Category(name: "Cats", url: "https://cataas.com/cat"),
                                          Category(name: "Random", url: "https://picsum.photos/800/1200"),
                                          Category(name: "Dogs", url: "https://loremflickr.com/800/1200/dog)")]
    
    func getCategories(success: ([Category]) -> Void, failure: (Error?) -> Void) {
        Thread.sleep(until: Date().addingTimeInterval(2.0))
        success(categories)
    }
}
