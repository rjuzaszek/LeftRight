//
//  MainCoordinator.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class MainCoordinator: NavigationCoordinator {
    override func start() {
        guard let extendedLaunchVC = UIStoryboard.init(name: "ExtendedLaunchScreen", bundle: nil).instantiateInitialViewController() as? ExtendedLaunchScreenViewController else { return }
        extendedLaunchVC.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([extendedLaunchVC], animated: false)
    }
}

extension MainCoordinator: ExtendedLaunchScreenCoordination {
    func finishAppLaunch() {
        let categoriesCoordinator = GameCoordinator(navigationController: navigationController)
        startChild(child: categoriesCoordinator)
    }
}
