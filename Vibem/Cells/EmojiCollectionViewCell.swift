//
//  EmojiCollectionViewCell.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/28/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class EmojiCollectionViewCell: UICollectionViewCell {
    static let identifier = "EmojiCollectionViewCell"
    
    private let emojiLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(emoji: Character, backgroundColor: UIColor) {
        
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 30 * screenHeightMultiplier
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = true
        
        emojiLabel.text = emoji.isEmoji ? String(emoji) : "🤡"
        emojiLabel.adjustsFontSizeToFitWidth = true
        emojiLabel.textAlignment = .center
        addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(45 * screenHeightMultiplier)
        }
    }
    
    public func toggleSelected() {
        layer.borderWidth = layer.borderWidth == 3 * screenHeightMultiplier ? 0 : 3 * screenHeightMultiplier
        print("toggleSelect \(emojiLabel.text!)")
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
