//
//  ImageDownloader.swift
//  LeftRight
//
//  Created by Robert Juzaszek on 03/04/2020.
//  Copyright © 2020 Robert Juzaszek. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    static let urlSession: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: sessionConfiguration)
    }()
    
    static func download(from link: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }
        download(from: url, completion: completion)
    }
    
    static func download(from url: URL, completion: @escaping (UIImage?) -> Void) {
        Self.urlSession.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }
}
