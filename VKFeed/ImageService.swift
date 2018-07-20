//
//  ImageService.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 14/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

final class ImageService {
    
    func fetchImage(
        url: URL,
        size: CGSize,
        onCompletion: @escaping (UIImage?) -> Void
    ) {
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        onCompletion(nil)
                    }
                    return
                }
                var image = UIImage(data: data)!
                image = self.decompress(image: image, size: size)
                DispatchQueue.main.async {
                    onCompletion(image)
                }
            }
            task.resume()
        }
    }
    
    func decompress(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(origin: .zero, size: size))
        context?.saveGState()
        context?.clip()
        image.draw(in: CGRect(origin: .zero, size: size))
        context?.restoreGState()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
