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
    static let shared = RootViewController()
    
    internal lazy var authVC: AuthViewController = {
        let authVC = AuthViewController(completion: authCompletion)
        return authVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.renewSession { isSuccessful in
            if isSuccessful {
                let emojiSelectionVC = EmojiSelectionViewController(completion: self.emojiSelectionCompletion)
                self.navigationController?.pushViewController(emojiSelectionVC, animated: false)
            } else {
                self.navigationController?.pushViewController(self.authVC, animated: false)
            }
        }
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

