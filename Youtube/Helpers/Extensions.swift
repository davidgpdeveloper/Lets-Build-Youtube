//
//  Extensions.swift
//  Youtube
//
//  Created by Studiogenesis Home on 8/7/18.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, view: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in view.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        
//        let url = NSURL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
            URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    
                    self.image = imageToCache
                }
            }).resume()
        
        
    }
    
}
