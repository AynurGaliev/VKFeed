//
//  FeedViewModel.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 11/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import Foundation
import CoreGraphics

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMMM"
    return formatter
}()

struct FeedViewModel {
    
    let avatarURL: URL?
    let dateString: String
    let nameString: String
    let likesCount: Int
    let postText: String
    
    func layout(for width: CGFloat) -> FeedCellLayout {
        return FeedCellLayout(viewModel: self, width: width)
    }
    
    init(feed: Feed) {
        self.avatarURL = URL(string: feed.avatarImageURLString)
        self.dateString = formatter.string(from: feed.date)
        self.nameString = feed.name
        self.likesCount = feed.likesCount
        self.postText = feed.postText
    }
}

struct Feed {
    let avatarImageURLString: String
    let name: String
    let likesCount: Int
    let date: Date
    let postText: String
}

func randomString(_ length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}
