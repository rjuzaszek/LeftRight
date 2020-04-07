//
//  CategoriesListViewModel.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 05/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoriesListViewModel: CategoriesListViewModelProtocol {
    
    let selectedIndexes = BehaviorRelay<[Int]>(value: [])
    
    
    //MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let categoriesService: CategoriesServiceProtocol
    
    private let categoriesSubject = BehaviorRelay<[Category]>(value: [])
    private let isFetchingSubject = BehaviorRelay<Bool>(value: false)
    private let errorSubject = BehaviorRelay<String?>(value: nil)
    
    //MARK: - Initialiser
    
    init(categoriesService: CategoriesServiceProtocol) {
        self.categoriesService = categoriesService
        fetchCategories()
    }
    
    //MARK: - Public interface
    
    var numberOfCategories: Int {
        return categoriesSubject.value.count
    }
    
    var isFetching: Driver<Bool> {
        return isFetchingSubject.asDriver().distinctUntilChanged()
    }
    
    var error: Driver<String?> {
        return errorSubject.asDriver()
    }
    
    var hasError: Bool {
        return errorSubject.value != nil
    }
    
    var categories: Driver<[Category]> {
        return categoriesSubject.asDriver()
    }
    
    var selectedCategories: [Category] {
        return selectedIndexes.value.map({ categoriesSubject.value[$0] })
    }
    
    var isPlayButtonEnabled: Driver<Bool> {
        return Observable.combineLatest(selectedIndexes.map({ !$0.isEmpty }), isFetchingSubject) { $0 && !$1 }.asDriver(onErrorJustReturn: false)
    }
    
    func categoryViewModel(forIndex: Int) -> CategoryViewModel? {
        guard forIndex < categoriesSubject.value.count else { return nil }
        return CategoryViewModel(category: categoriesSubject.value[forIndex])
    }
}

//MARK: - Private functions
private extension CategoriesListViewModel {
    func fetchCategories() {
        categoriesSubject.accept([])
        isFetchingSubject.accept(true)
        errorSubject.accept(nil)
        
        categoriesService.getCategories(success: { [weak self] categories in
            self?.isFetchingSubject.accept(false)
            self?.categoriesSubject.accept(categories)
        }, failure: { [weak self] error in
            self?.isFetchingSubject.accept(false)
            self?.errorSubject.accept(error?.localizedDescription)
        })
    }
}
