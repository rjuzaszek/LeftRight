//
//  CategoriesSelectionCoordinator.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class GameCoordinator: NavigationCoordinator {
    override func start() {
        guard let categoriesSelectionVC = UIStoryboard(name: CategoriesList.storyboardName, bundle: nil).instantiateInitialViewController() as? CategoriesListViewController else { return }
        categoriesSelectionVC.coordinator = self
        navigationController.setViewControllers([categoriesSelectionVC], animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    
}

extension GameCoordinator: CategoriesListCoordination {
    func startGame(categories: [Category]) {
        guard !categories.isEmpty else { return }
        let swipeCardsViewModel = SwipeCardsViewModel(categories: categories)
        let swipeCardsVC = SwipeCardsViewController()
        swipeCardsVC.viewModel = swipeCardsViewModel
        swipeCardsVC.coordinator = self
        navigationController.pushViewController(swipeCardsVC, animated: true)
    }
}

extension GameCoordinator: SwipeCardsCoordination {
    func close() {
        navigationController.popViewController(animated: true)
    }
}
