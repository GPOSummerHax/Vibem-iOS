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

    private lazy var emojiSelectionViewController: EmojiSelectionViewController = {
        return EmojiSelectionViewController(completion: emojiSelectionCompletion)
    }()
    
    private lazy var emojiConfirmationViewController: EmojiConfirmationViewController = {
        return EmojiConfirmationViewController(completion: emojiConfirmCompletion)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        navigationController?.pushViewController(AuthViewController(), animated: false)
//        navigationController?.pushViewController(emojiSelectionViewController, animated: false)
    }
    
    private func emojiSelectionCompletion() {
        navigationController?.pushViewController(emojiConfirmationViewController, animated: true)
    }
    
    private func emojiConfirmCompletion() {
        print("confirmed")
    }
}

