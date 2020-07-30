//
//  ViewController.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {

    private let emojiSelectionView = EmojiSelectionViewController()
    private let emojiConfirmationView = EmojiConfirmationViewController()
    private let hardCodedEmojiData: [(Character, UIColor)] =
        [("😗", UIColor(hexCode: "#FFD94EFF")!), ("🎉", UIColor(hexCode: "#DDDF8BFF")!), ("🔮", UIColor(hexCode: "#F7C0FAFF")!), ("🔥", UIColor(hexCode: "#FFA40DFF")!), ("🤡", UIColor(hexCode: "#E77B6DFF")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        emojiSelectionView.configure(completion: emojiSelectionCompletion)
        self.view = emojiSelectionView
        
        setConstraints()
    }
    
    private func emojiSelectionCompletion(emojiData: [(Character, UIColor)]) {
        emojiConfirmationView.configure(emojiData: emojiData)
        let emojiConfirmationViewController = UIViewController()
        emojiConfirmationViewController.view = emojiConfirmationView
        navigationController?.pushViewController(emojiConfirmationViewController, animated: true)
    }

    private func setConstraints() {
//        emojiSelectionView.snp.makeConstraints { make in
//            make.top.bottom.leading.trailing.equalToSuperview()
//        }
    }
}

