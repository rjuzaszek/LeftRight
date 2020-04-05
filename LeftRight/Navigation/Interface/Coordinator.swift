//
//  Coordinator.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 31/03/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
}

extension Coordinator {
    func startChild(child: Coordinator) {
        children.append(child)
        child.parent = self
        child.start()
    }
    
    func childDidFinish(child: Coordinator) {
        children.removeAll(where: { $0 === child })
    }
}
