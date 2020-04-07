//
//  RestPictureUrlStrategy.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 07/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Foundation

struct RestPictureUrlStrategy: GetPictureUrlStrategy {
    
    private let fieldName: String
    private let errorPhotoUrl = "https://i.kym-cdn.com/photos/images/original/001/607/299/939.jpeg"
    
    init(fieldName: String) {
        self.fieldName = fieldName
    }
    
    func getPicutreUrl(from url: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: url) else {
            returnUrl(url: errorPhotoUrl, completion: completion)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data,
                  let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let photoUrl = responseDictionary[self.fieldName] as? String else {
                    self.returnUrl(url: self.errorPhotoUrl, completion: completion)
                    return
            }
            self.returnUrl(url: photoUrl, completion: completion)
        }).resume()
    }
    
    private func returnUrl(url: String, completion: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            completion(url)
        }
    }
}
