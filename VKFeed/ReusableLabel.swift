//
//  ReusableLabel.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 16/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import UIKit

//final class ReusableLabel: UILabel {
//
////    var image: CGImage?
////
//    override func draw(_ rect: CGRect) {
//        super.drawText(in: rect)
//
//    }
//}


//final class LabelLayer: CALayer {
//
//    var attributedString: NSAttributedString?
//
//    override func display() {
//        super.display()
//
//        DispatchQueue.global(qos: .userInteractive).async {
//
//            UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 1.0)
//            let context = UIGraphicsGetCurrentContext()
//            context?.setFillColor(UIColor.white.cgColor)
//            context?.fill(self.bounds)
//            self.attributedString?.draw(in: self.bounds)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//
//            DispatchQueue.main.async {
//                self.contents = image?.cgImage
//            }
//        }
//    }
//}
