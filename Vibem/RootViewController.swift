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
    
    internal lazy var authVC = AuthViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // testing loadingAnimationView
//        for i in 0..<5 {
//            Emojis.selected.insert(Emojis.objects[i])
//        }
        let emojiSelectionVC = EmojiSelectionViewController(completion: emojiSelectionCompletion)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(emojiSelectionVC, animated: false)
    }
    
    private func emojiSelectionCompletion() {
        let emojiConfirmationVC = EmojiConfirmationViewController(completion: emojiConfirmCompletion)
        navigationController?.present(emojiConfirmationVC, animated: true)
    }
    
    private func emojiConfirmCompletion() {
        print("confirmed")
    }
}

