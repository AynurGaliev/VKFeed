//
//  FeedCell.swift
//  AsyncLayout
//
//  Created by Aynur Galiev on 11/07/2018.
//  Copyright © 2018 Aynur Galiev. All rights reserved.
//

import UIKit

final class FeedCell: UITableViewCell {

    struct Constants {
        static let nameFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        static let dateFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        static let nameColor = UIColor(red: 36, green: 36, blue: 36)
        static let dateColor = UIColor(red: 224, green: 224, blue: 224)
    }
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameFont
        label.textColor = Constants.nameColor
        return label
    }()
    
    private let postTextLabel: ReusableLabel = {
        let label = ReusableLabel()
        label.font = Constants.nameFont
        label.textColor = Constants.nameColor
        label.numberOfLines = 0
        label.isOpaque = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dateFont
        label.textColor = Constants.dateColor
        return label
    }()
    
    private var viewModel: FeedViewModel? {
        didSet {
//            setNeedsLayout()
        }
    }
    
    private var layout: FeedCellLayout? {
        didSet {
            
        }
    }
    
    func avatarImageCallback(image: UIImage?) {
        self.avatarImageView.image = image
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(postTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: FeedViewModel, layout: FeedCellLayout) {
        self.viewModel = viewModel
        self.layout = layout
        if nameLabel.text != viewModel.nameString {
            self.nameLabel.text = viewModel.nameString
        }
        if dateLabel.text != viewModel.dateString {
            self.dateLabel.text = viewModel.dateString
        }
        if postTextLabel.text != viewModel.postText {
            postTextLabel.setText(viewModel.postText, cachedLayout: layout.postLabelExpandedCachedLayout)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = self.layout else { return }
        avatarImageView.frame = layout.avatarImageViewFrame
        nameLabel.frame = layout.nameLabelFrame
        dateLabel.frame = layout.dateLabelFrame
        postTextLabel.frame = layout.postTextFrame
    }
}

