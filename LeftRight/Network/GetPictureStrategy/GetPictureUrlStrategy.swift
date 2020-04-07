//
//  GetPictureUrlStrategy.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 06/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation


protocol GetPictureUrlStrategy {
    func getPicutreUrl(from url: String, completion: @escaping (String) -> Void)
}
