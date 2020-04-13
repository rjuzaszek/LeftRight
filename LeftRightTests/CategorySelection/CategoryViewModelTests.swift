//
//  CategoryViewModelTests.swift
//  LeftRightTests
//
//  Created by Robert Juzaszek on 08/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking

@testable import LeftRight

class CategoryViewModelTests: XCTestCase {
    
    var viewModel: CategoriesListViewModelProtocol!
    var mockedService = MockedCategories()
    
    override func setUp() {
        viewModel = CategoriesListViewModel(categoriesService: mockedService)
    }

    override func tearDown() {
    }

    func testIsPlayButtonEnabledWhenSelectionEmpty() throws {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        let playButtonObservable = viewModel.isPlayButtonEnabled.asObservable().skip(1).subscribeOn(scheduler)
        
        viewModel.selectedIndexes.accept([0])
        viewModel.selectedIndexes.accept([])
        XCTAssertEqual(false, try playButtonObservable.toBlocking().first()!)
    }
    
    func testIsPlayButtonEnabledWhenSelectionExists() throws {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        let playButtonObservable = viewModel.isPlayButtonEnabled.asObservable().skip(1).subscribeOn(scheduler)
        
        viewModel.selectedIndexes.accept([0])
        XCTAssertEqual(true, try playButtonObservable.toBlocking().first()!)
    }
}
