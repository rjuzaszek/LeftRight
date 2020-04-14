//
//  MockedCategories.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 07/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

class MockedCategories: CategoriesServiceProtocol {
    
    private let c1 = Category(name: "Cats", path: "https://cataas.com/cat", method: "SIMPLE", parameters: [:])
    private let c2 = Category(name: "Dogs", path: "https://dog.ceo/api/breeds/image/random", method: "REST", parameters: ["fieldName": "message"])
    private let c3 = Category(name: "Random", path: "https://picsum.photos/800/1200", method: "SIMPLE", parameters: [:])
    
    func getCategories(success: @escaping ([Category]) -> Void, failure: @escaping (Error?) -> Void) {
        let categories: [Category] = [c1,c2,c3]
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(until: Date().addingTimeInterval(2.0))
            DispatchQueue.main.async {
                success(categories)
            }
        }
    }
}
