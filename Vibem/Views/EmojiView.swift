//
//  EmojiView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class EmojiView: UIView {

    private let emojiLabel = UILabel()
    
    init(emoji: Character, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 30 * screenHeightMultiplier
        layer.borderColor = UIColor(hexCode: "#B5B5B5FF")!.cgColor
        clipsToBounds = true
        
        emojiLabel.text = emoji.isEmoji ? String(emoji) : "🤡"
        emojiLabel.backgroundColor = .clear
        emojiLabel.font = emojiLabel.font.withSize(30 * screenHeightMultiplier)
        emojiLabel.textAlignment = .center
        addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
