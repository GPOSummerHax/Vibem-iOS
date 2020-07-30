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

    private let emojiSelectionViewController = EmojiSelectionViewController()
    private let emojiConfirmationViewController = EmojiConfirmationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        emojiSelectionViewController.configure(completion: emojiSelectionCompletion)
        navigationController?.pushViewController(emojiSelectionViewController, animated: false)
    }
    
    private func emojiSelectionCompletion(emojiData: [(Character, UIColor)]) {
        emojiConfirmationViewController.configure(emojiData: emojiData)
        navigationController?.pushViewController(emojiConfirmationViewController, animated: true)
    }
}

