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
    
    var emojiObject: EmojiObject!
    
    private lazy var emojiView: UIView = {
        let emojiView = UIView()
        emojiView.backgroundColor = emojiObject.backgroundColor
        emojiView.layer.cornerRadius = 30 * screenHeightMultiplier
        emojiView.layer.borderColor = UIColor("#B5B5B5FF").cgColor
        emojiView.clipsToBounds = true
        
        let emojiLabel = UILabel()
        emojiLabel.text = emojiObject.emoji.isEmoji ? String(emojiObject.emoji) : "🤡"
        emojiLabel.backgroundColor = .clear
        emojiLabel.font = emojiLabel.font.withSize(30 * screenHeightMultiplier)
        emojiLabel.textAlignment = .center
        emojiView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
        
        return emojiView
    }()
    
    private lazy var checkCircleView: UIView = {
        let checkCircleView = UIView()
        checkCircleView.backgroundColor = UIColor("#D5E0A6FF")
        checkCircleView.layer.cornerRadius = 11.5 * screenHeightMultiplier
        checkCircleView.layer.borderColor = UIColor.white.cgColor
        checkCircleView.layer.borderWidth = 3 * screenHeightMultiplier
        let checkMark = UIImageView(image: UIImage(named: "checkMark"))
        checkCircleView.addSubview(checkMark)
        checkMark.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(10)
        }
        return checkCircleView
    }()
    
    
    public var isChecked: Bool {
        get {
            return Emojis.selected.contains(emojiObject)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func configure(emojiObject: EmojiObject) {
        self.backgroundColor = .clear
        clipsToBounds = false
        self.emojiObject = emojiObject
        
        addSubview(emojiView)
        addSubview(checkCircleView)
        
        checkCircleView.alpha = 0
        
        setConstraints()
        
        setSelected(to: isChecked)
    }
    
    public func setSelected(to isSelected: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.emojiView.layer.borderWidth = isSelected ? 3 * screenHeightMultiplier : 0
            self.checkCircleView.alpha = isSelected ? 1 : 0
        }
    }
    
    private func setConstraints() {
        emojiView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
        checkCircleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(5 * screenHeightMultiplier)
            make.top.equalToSuperview().offset(-5 * screenHeightMultiplier)
            make.height.width.equalTo(23 * screenHeightMultiplier)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
