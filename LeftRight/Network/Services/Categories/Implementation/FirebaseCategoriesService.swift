//
//  FirebaseCategoriesService.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 14/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import Firebase

enum NetworkError: Error {
    case noDatabaseSnapshot
    case parsingElementFailed
}

class FirebaseCategoriesService: CategoriesServiceProtocol {
    
    private let database = Firestore.firestore()
    
    func getCategories(success: @escaping ([Category]) -> Void, failure: @escaping (Error?) -> Void) {
        database.collection("leftright").getDocuments(completion: { [weak self] snapshot, error in
            guard let self = self else { return }
            guard error == nil else {
                failure(error)
                return
            }
            
            guard let snapshot = snapshot else {
                failure(NetworkError.noDatabaseSnapshot)
                return
            }
            
            var categories = [Category]()
            for document in snapshot.documents {
                let category = self.makeCategory(from: document.data())
                categories.append(category)
            }
            success(categories)
        })
    }
    
    private func makeCategory(from dict: [String: Any]) -> Category {
        let name = dict["name"] as? String ?? ""
        let path = dict["path"] as? String ?? ""
        let thumbnail = dict["thumbnailUrl"] as? String ?? ""
        let method = dict["method"] as? String ?? ""
        let parameters = dict["parameters"] as? [String: Any] ?? [:]
        
        return Category(name: name, thumbnailUrl: thumbnail, path: path, method: method, parameters: parameters)
    }
}
