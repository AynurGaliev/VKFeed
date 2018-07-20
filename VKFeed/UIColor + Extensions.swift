//
//  UIColor + Extensions.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 12/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red)/225.0,
            green: CGFloat(green)/255.0,
            blue: CGFloat(blue)/255.0,
            alpha: alpha
        )
    }
}
