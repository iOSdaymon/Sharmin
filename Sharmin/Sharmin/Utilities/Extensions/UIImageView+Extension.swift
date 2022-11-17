//
//  UIImageView+Extension.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func set(_ pictureUri: String?) {
        guard let url = pictureUri else { return }
        load(urlString: url, completion: { [weak self] urlString, newImage in
            guard url == urlString else { return }
            self?.image = newImage
        })
    }
    
    func load(urlString: String, completion: @escaping (_ urlString: String, _ image: UIImage) -> ()) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            completion(urlString, image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            // Create Data Task
            let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let imageData = data,
                      let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    completion(urlString, image)
                }
            }
            
            // Start Data Task
            dataTask.resume()
        }
    }
    
}
