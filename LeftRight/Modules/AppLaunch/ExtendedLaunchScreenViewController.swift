//
//  LaunchScreenViewController.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

protocol ExtendedLaunchScreenCoordination: class {
    func finishAppLaunch()
}

class ExtendedLaunchScreenViewController: UIViewController {
    
    //MARK: - Public properties
    
    weak var coordinator: ExtendedLaunchScreenCoordination?
    
    //MARK: - Private properties
    
    @IBOutlet private var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        logoImageView.image = UIImage(named: "launch_icon")
        logoImageView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0, animations: {
            self.logoImageView.alpha = 1.0
        }, completion: { _ in
            self.coordinator?.finishAppLaunch()
        })
    }
}
