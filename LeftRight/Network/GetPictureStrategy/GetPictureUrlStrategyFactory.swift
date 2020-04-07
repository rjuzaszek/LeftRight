//
//  GetPictureUrlStrategyFactory.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 06/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

class GetPictureUrlStrategyFactory {
    
    static func make(type: String, parameters: [String: Any]) -> GetPictureUrlStrategy {
        switch type.uppercased() {
        case "REST":
            let fieldName = parameters["fieldName"] as? String ?? ""
            return RestPictureUrlStrategy(fieldName: fieldName)
            
        case "SIMPLE":
            return SimpleGetPictureStrategy()
            
        default:
            return SimpleGetPictureStrategy()
        }
    }
}
