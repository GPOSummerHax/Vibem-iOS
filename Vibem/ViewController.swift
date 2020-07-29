//
//  ViewController.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let emojiSelectView = EmojiSelectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        view.addSubview(emojiSelectView)
        
        
        setConstraints()
    }

    private func setConstraints() {
        emojiSelectView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

