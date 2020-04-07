//
//  Category.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

struct Category {
    var name: String
    var thumbnailImageUrl: String = ""
    var url: String = ""
    
    //another object later / rest = fieldName
    var method: String
    var parameters: [String: Any]
}
