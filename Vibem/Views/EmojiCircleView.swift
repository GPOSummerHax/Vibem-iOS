//
//  EmojiCircleView.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/20/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class EmojiCircleView: UIView {

    private lazy var emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.text = emojiLabelText
        emojiLabel.backgroundColor = .clear
        emojiLabel.font = emojiLabel.font.withSize(30 * heightMultiplier)
        emojiLabel.textAlignment = .center
        return emojiLabel
    }()
    
    private var emojiLabelText: String {
        get {
            return String(emojiObject.emoji)
        }
    }
    
    private var emojiObject: EmojiObject!
    
    init(emojiObject: EmojiObject) {
        super.init(frame: .zero)
        
        self.emojiObject = emojiObject
        
        backgroundColor = emojiObject.backgroundColor
        layer.cornerRadius = 30 * heightMultiplier
        layer.borderColor = UIColor("#B5B5B5FF").cgColor
        clipsToBounds = true
        
        addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
        
    }
    
    public func update(to emojiObject: EmojiObject) {
        self.emojiObject = emojiObject
        emojiLabel.text = emojiLabelText
        backgroundColor = emojiObject.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
