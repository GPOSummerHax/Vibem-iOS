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
    
    private lazy var emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.text = emojiLabelText
        emojiLabel.backgroundColor = .clear
        emojiLabel.font = emojiLabel.font.withSize(30 * screenHeightMultiplier)
        emojiLabel.textAlignment = .center
        return emojiLabel
    }()
    
    private lazy var emojiView: UIView = {
        let emojiView = UIView()
        emojiView.backgroundColor = emojiObject.backgroundColor
        emojiView.layer.cornerRadius = 30 * screenHeightMultiplier
        emojiView.layer.borderColor = UIColor("#B5B5B5FF").cgColor
        emojiView.clipsToBounds = true
        
        emojiView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
        
        return emojiView
    }()
    
    private lazy var emojiDescriptionLabel: UILabel = {
        let emojiDescriptionLabel = UILabel()
        emojiDescriptionLabel.text = emojiDescription
        emojiDescriptionLabel.textColor = .black
        emojiDescriptionLabel.font = ._18DMSansBold
        emojiDescriptionLabel.numberOfLines = 0
        return emojiDescriptionLabel
    }()
    
    private var emojiObject: EmojiObject!
    private var emojiLabelText: String {
        get {
            return emojiObject.emoji.isEmoji ? String(emojiObject.emoji) : "🤡"
        }
    }
    
    private var emojiDescription: String? {
        get {
            return Emojis.description(for: emojiObject.emoji)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.backgroundColor = .white
    }
    
    func configure(emojiObject: EmojiObject) {
        self.emojiObject = emojiObject
        
        contentView.addSubview(emojiView)
        contentView.addSubview(emojiDescriptionLabel)
        
        emojiLabel.text = emojiLabelText
        
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
