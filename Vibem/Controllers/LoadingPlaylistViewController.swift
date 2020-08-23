//
//  LoadingPlaylistViewController.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/20/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import Stellar

class LoadingPlaylistViewController: UIViewController {

    private var touched: Bool = false
    
    private let circleRadius: CGFloat = 30 * heightMultiplier
    private let revolutionRadius: CGFloat = 100 * heightMultiplier

    private lazy var circles: [EmojiCircleView] = {
        return Array(Emojis.objects.map {
            return EmojiCircleView(emojiObject: $0)
        }.prefix(5))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "animation testing"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for circle in circles {
            view.addSubview(circle)
            circle.snp.remakeConstraints { make in
                make.height.width.equalTo(circleRadius * 2)
                make.centerX.centerY.equalToSuperview()
            }
        }
        touched = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if !touched {
            revolve()
        }
        touched = true
    }
    
    private func revolve() {
        let anchorPoint: CGPoint = CGPoint(x: -revolutionRadius / (2 * circleRadius) + 0.5, y: 0.5)
        
        for i in 0..<circles.count {
            let circle = circles[i]
            circle
                .anchorPoint(anchorPoint).delay(2 / Double(circles.count) * Double(i)).then()
                .rotate(2 * .pi).duration(2).easing(.linear).repeatCount(1000).then()
                .animate()
        }
    }
}
