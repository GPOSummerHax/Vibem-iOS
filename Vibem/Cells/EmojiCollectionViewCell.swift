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
    
    private var emojiView: EmojiView!
    private let checkCircleView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(emoji: Character, backgroundColor: UIColor) {
        
        self.backgroundColor = .clear
        clipsToBounds = false
        
        emojiView = EmojiView(emoji: emoji, backgroundColor: backgroundColor)
        addSubview(emojiView)
        emojiView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
        
        checkCircleView.backgroundColor = UIColor(hexCode: "#D5E0A6FF")
        checkCircleView.layer.cornerRadius = 11.5 * screenHeightMultiplier
        checkCircleView.layer.borderColor = UIColor.white.cgColor
        checkCircleView.layer.borderWidth = 3 * screenHeightMultiplier
        let checkMark = UIImageView(image: UIImage(named: "checkMark"))
        checkCircleView.addSubview(checkMark)
        checkMark.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(10)
        }
        addSubview(checkCircleView)
        checkCircleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(5 * screenHeightMultiplier)
            make.top.equalToSuperview().offset(-5 * screenHeightMultiplier)
            make.height.width.equalTo(23 * screenHeightMultiplier)
        }
        checkCircleView.alpha = 0
    }
    
    public func toggleSelected() {
        UIView.animate(withDuration: 0.25) {
            self.emojiView.layer.borderWidth = self.emojiView.layer.borderWidth == 3 * screenHeightMultiplier ? 0 : 3 * screenHeightMultiplier
            self.checkCircleView.alpha = self.checkCircleView.alpha == 1 ? 0 : 1
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
