//
//  FeedLayout.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 11/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct FeedCellLayout {
    
    let avatarImageViewFrame: CGRect
    let nameLabelFrame: CGRect
    let dateLabelFrame: CGRect
    let postTextFrame: CGRect
    
    let postLabelExpandedCachedLayout: ReusableLabelCachedLayout
    
    let height: CGFloat
    
    init(viewModel: FeedViewModel, width: CGFloat) {
        
        var height: CGFloat = 60
        //MARK: - Avatar image view
        self.avatarImageViewFrame = CGRect(
            x: 10,
            y: 10,
            width: 40,
            height: 40
        )
        //MARK: - Name label
        let nameAttributedString = NSAttributedString(
            string: viewModel.nameString,
            attributes: [
                .font: FeedCell.Constants.nameFont,
                .foregroundColor: FeedCell.Constants.nameColor
            ]
        )
        let nameSize = nameAttributedString.boundingRect(
            with: CGSize(
                width: width - 70,
                height: CGFloat.greatestFiniteMagnitude
            ),
            options: [.usesFontLeading],
            context: nil
        )
        self.nameLabelFrame = CGRect(
            x: 60,
            y: 10,
            width: ceil(nameSize.width),
            height: ceil(FeedCell.Constants.nameFont.lineHeight)
        )
        //MARK: - Date label
        let dateAttributedString = NSAttributedString(
            string: viewModel.dateString,
            attributes: [
                .font: FeedCell.Constants.dateFont,
                .foregroundColor: FeedCell.Constants.dateColor
            ]
        )
        let dateSize = dateAttributedString.boundingRect(
            with: CGSize(
                width: width - 70,
                height: CGFloat.greatestFiniteMagnitude
            ),
            options: [.usesFontLeading],
            context: nil
        )
        self.dateLabelFrame = CGRect(
            x: 60,
            y: 10 + nameSize.height + 5,
            width: ceil(dateSize.width),
            height: ceil(FeedCell.Constants.dateFont.lineHeight)
        )

        // MARK: - Post text
        let postTextAttributedString = NSAttributedString(
            string: viewModel.postText,
            attributes: [
                .font: FeedCell.Constants.dateFont,
                .foregroundColor: FeedCell.Constants.dateColor
            ]
        )
        
        self.postLabelExpandedCachedLayout = ReusableLabelCachedLayout(
            string: viewModel.postText,
            attributes: [
                NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 14.0, weight: .regular)
            ],
            maxLinesCount: 0,
            constrainedWidth: width - 32
        )
        
        self.postTextFrame = CGRect(
            x: 16,
            y: height,
            width: ceil(self.postLabelExpandedCachedLayout.renderedSize().width),
            height: ceil(self.postLabelExpandedCachedLayout.renderedSize().height)
        )
        
        height += self.postLabelExpandedCachedLayout.renderedSize().height + 10
        
        self.height = height
    }
}
