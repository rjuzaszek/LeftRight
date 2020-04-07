//
//  CategoriesService.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 05/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

protocol CategoriesServiceProtocol {
    func getCategories(success: @escaping ([Category]) -> Void, failure: @escaping (Error?) -> Void)
}
