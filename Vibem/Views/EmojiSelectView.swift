//
//  EmojiSelectView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class EmojiSelectView: UIView {

    private let promptLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemPink // for initial test
        
        promptLabel.text = "how are you feeling?"
        promptLabel.textColor = .black
        addSubview(promptLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        promptLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
