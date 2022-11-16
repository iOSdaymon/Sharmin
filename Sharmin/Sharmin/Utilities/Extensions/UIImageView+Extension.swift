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
        if let url = pictureUri {
            load(urlString: url, completion: { [weak self] urlString, image in
                guard url == urlString else { return }
                self?.image = image
            })
        }
    }
    
    func load(urlString: String, completion: @escaping (_ urlString: String, _ image: UIImage) -> ()) {
        
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            completion(urlString, image)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        completion(urlString, image)
                    }
                }
            } catch (let error) {
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
}
