//
//  LoadingAnimationView.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/23/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import Stellar

class LoadingAnimationView: UIView {
    
    // MARK: Subviews
    private lazy var circles: [EmojiCircleView] = {
        return Array(Emojis.selected.map {
            return EmojiCircleView(emojiObject: $0)
        }.prefix(5))
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "loading..."
        label.font = ._18DMSansBold
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Layout Constants
    private let emojiCircleRadius = 30 * heightMultiplier
    private let revolutionRadius = 100 * heightMultiplier
    private let leadingOffset = 25 * widthMultiplier
    private var topOffset = 182 * heightMultiplier
    private let emojiCircleSpacing = 100 * heightMultiplier
    
    // MARK: Initialize & Layout
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0)
        addSubview(loadingLabel)
        loadingLabel.alpha = 0
        loadingLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        for circle in circles {
            addSubview(circle)
            circle.snp.remakeConstraints { make in
                make.height.width.equalTo(emojiCircleRadius * 2)
                make.leading.equalToSuperview().offset(leadingOffset)
                make.top.equalToSuperview().offset(topOffset)
            }
            topOffset += emojiCircleSpacing
        }
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    private var touched = false
    private let presentAnimationDuration: TimeInterval = 0.25
    private let cycleDuration: Double = 1.25
    private var blinkTimer: Timer?
    
    private func revolve1() {
        for i in 0..<circles.count {
            let anchorPoint: CGPoint = CGPoint(
                x: -revolutionRadius / (2 * emojiCircleRadius) + 0.5,
                y: 0.5)
            let circle = circles[i]
            circle
                .moveTo(center).anchorPoint(anchorPoint).rotate(CGFloat(i) * -2 * .pi / CGFloat(circles.count))
                .duration(cycleDuration * 2/3).easing(.easeIn).then()
                .rotate(-2 * .pi).duration(cycleDuration).easing(.linear).repeatCount(100).then()
                .animate()
        }
    }
    
//    private func revolve2() {
//        for i in 0..<circles.count {
//            let anchorPoint: CGPoint = CGPoint(
//                x: revolutionRadius / (2 * emojiCircleRadius) + 0.5,
//                y: 0.5)
//            let circle = circles[i]
//            circle
//                .moveTo(center).anchorPoint(anchorPoint).rotate(-.pi)
//                .delay(cycleDuration / Double(circles.count) * Double(i))
//                .duration(1).easing(.easeIn).then()
//                .rotate(-2 * .pi).duration(cycleDuration).easing(.linear).repeatCount(100).then()
//                .animate()
//        }
//    }
    
    @objc private func loadingBlink() {
        let blinkInterval = 0.75
        loadingLabel
            .makeAlpha(0).duration(blinkInterval).easing(.linear).then()
            .makeAlpha(1).duration(blinkInterval).easing(.linear).then()
            .animate()
        blinkTimer?.invalidate()
        blinkTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(loadingBlink), userInfo: nil, repeats: false)
    }
    
    func stopAnimations() {
        DispatchQueue.main.async {
            self.cancelAllRemaining()
            self.blinkTimer?.invalidate()
        }
    }
    
    internal func present() {
        UIView.transition(
            with: self,
            duration: presentAnimationDuration,
            options: .transitionCrossDissolve) {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            self.loadingLabel.alpha = 1
        } completion: { (_) in
            self.isUserInteractionEnabled = true
            self.revolve1()
            self.loadingBlink()
        }
    }
}
