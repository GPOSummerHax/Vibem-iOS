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
    
    internal lazy var authVC: AuthViewController = {
        let authVC = AuthViewController(completion: authCompletion)
        return authVC
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // testing loadingAnimationView
//        for i in 0..<5 {
//            Emojis.selected.insert(Emojis.objects[i])
//        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(authVC, animated: false)
    }
    
    private func authCompletion() {
        let emojiSelectionVC = EmojiSelectionViewController(completion: emojiSelectionCompletion)
        navigationController?.pushViewController(emojiSelectionVC, animated: true)
    }
    
    private func emojiSelectionCompletion() {
        let emojiConfirmationVC = EmojiConfirmationViewController(completion: emojiConfirmCompletion)
        navigationController?.present(emojiConfirmationVC, animated: true)
    }
    
    private func emojiConfirmCompletion() {
        print("confirmed")
    }
}

