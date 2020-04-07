//
//  CategoriesListViewModel.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CategoriesList {
    static let storyboardName = "CategoriesList"
    
    enum Cells: String, CaseIterable {
        case selection = "CategorySelectionCell"
    }
}

protocol CategoriesListViewModelProtocol {
    var numberOfCategories: Int { get }
    var isFetching: Driver<Bool> { get }
    var error: Driver<String?> { get }
    var hasError: Bool { get }
    var categories: Driver<[Category]> { get }
    var selectedIndexes: BehaviorRelay<[Int]> { get }
    var selectedCategories: [Category] { get }
    var isPlayButtonEnabled: Driver<Bool> { get }
    
    func categoryViewModel(forIndex: Int) -> CategoryViewModel?
}

protocol CategoriesListCoordination: class {
    func startGame(categories: [Category])
}
