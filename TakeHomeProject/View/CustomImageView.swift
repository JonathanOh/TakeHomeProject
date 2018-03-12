//
//  CustomImageView.swift
//  TakeHomeProject
//
//  Created by Jonathan Oh on 3/11/18.
//  Copyright © 2018 Jonathan Oh. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    static let imageCache = NSCache<AnyObject, UIImage>()
    
    // Subclass UIImageView to implement property that will help ensure proper image displays on proper cells by comparing urlstring requested to urlStringToCompare
    private var urlStringToCompare = ""
    func setImageFromURL(_ urlString: String) {
        image = nil
        urlStringToCompare = urlString
        if let imageExists = CustomImageView.imageCache.object(forKey: urlString as AnyObject) {
            image = imageExists
            return
        }
        HTTPManager.shared.getDataFromURLString(urlString) { [weak self] (imageData) in
            guard let catImage = UIImage(data: imageData) else { return }
            CustomImageView.imageCache.setObject(catImage, forKey: urlString as AnyObject)
            DispatchQueue.main.async { [weak self] in
                if self?.urlStringToCompare == urlString {
                    self?.image = catImage
                }
            }
        }
    }
}
