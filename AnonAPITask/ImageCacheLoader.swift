//
//  ImageCacheLoader.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import Foundation

class ImageCacheLoader {
    static let shared = ImageCacheLoader()
    var loaders: NSCache<NSString, ImageFetcher> = NSCache()
    
    func loaderFor(id: String, url: URL) -> ImageFetcher {
        let key = NSString(string: id)
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageFetcher(url: url)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}
