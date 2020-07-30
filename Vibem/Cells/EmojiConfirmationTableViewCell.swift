//
//  EmojiConfirmationTableViewCell.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class EmojiConfirmationTableViewCell: UITableViewCell {

    static let identifier = "EmojiConfirmationTableViewCell"
    private var emojiView: EmojiView!
    private var emojiDescriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(emoji: Character, backgroundColor: UIColor, emojiDescription: String) {
        emojiView = EmojiView(emoji: emoji, backgroundColor: backgroundColor)
        contentView.addSubview(emojiView)
        
        emojiDescriptionLabel.text = emojiDescription
        emojiDescriptionLabel.font = ._18DMSansBold
        emojiDescriptionLabel.numberOfLines = 0
        contentView.addSubview(emojiDescriptionLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        emojiView.snp.makeConstraints { make in
            make.height.width.equalTo(60 * screenWidthMultiplier)
            make.leading.centerY.equalToSuperview()
        }
        emojiDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(emojiView.snp.trailing).offset(20 * screenWidthMultiplier)
            make.centerY.trailing.equalToSuperview()
            make.height.equalTo(30 * screenHeightMultiplier)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
