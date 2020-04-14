//
//  CategoryViewViewModel.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 05/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

struct CategoryViewModel {
    var name: String
    var thumbnailUrl: String
    
    init(category: Category) {
        name = category.name
        thumbnailUrl = category.thumbnailUrl
    }
}
