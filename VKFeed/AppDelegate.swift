//
//  AppDelegate.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 11/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let text = NSAttributedString(
            string: "asdf;kfglcmvb,cvmb,cmlksjlfkdjflgkdflgdkfglkdjfglkdsdfsdfklmdlkfjglkdjfldkfjgldkfglkdjflgkjdlfgjdlkfgjldfjg",
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ]
        )
        
//        let layout = ReusableLabelCachedLayout(
//            string: "asdf;kfglcmvb,cvmb,cmlksjlfkdjflgkdflgdkfglkdjfglkdsdfsdfklmdlkfjglkdjfldkfjgldkfglkdjflgkjdlfgjdlkfgjldfjg",
//            attributes: [NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 16, weight: .bold)],
//            maxLinesCount: 2,
//            constrainedWidth: UIScreen.main.bounds.width
//        )
//
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 500))
        let context = UIGraphicsGetCurrentContext()
        text.draw(in: CGRect(x: 0, y: 0, width: 100, height: 500))
        let image = context?.makeImage()
        UIGraphicsEndImageContext()
        
        var start = CACurrentMediaTime()
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 500))
        text.draw(in: CGRect(x: 0, y: 0, width: 100, height: 500))
        UIGraphicsEndImageContext()
        var end = CACurrentMediaTime()
        print("First - \(end - start)")
        
        start = CACurrentMediaTime()
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 500))
        context?.draw(image!, in: CGRect(x: 0, y: 0, width: 100, height: 500))
        UIGraphicsEndImageContext()
        end = CACurrentMediaTime()
        print("Second - \(end - start)")
        
        return true
    }
}

