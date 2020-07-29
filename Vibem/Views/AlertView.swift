//
//  AlertView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class AlertView: UIView {

    private var blurView: UIVisualEffectView!
    private let blurViewAlpha: CGFloat = 1
    private let alertView = UIView()
    private let alertLabel = UILabel()
    
    init(alertText: String) {
        super.init(frame: .zero)
        
        isUserInteractionEnabled = false
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = blurViewAlpha
        blurView.backgroundColor = .clear
        addSubview(blurView)
        
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 10 * screenHeightMultiplier
        alertView.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        alertView.layer.shadowOffset = CGSize(width: 0, height: 4)
        alertView.layer.shadowRadius = 4 * screenHeightMultiplier
        alertView.layer.shadowOpacity = 1
        addSubview(alertView)
        
        alertLabel.text = alertText
        alertLabel.font = ._14DMSansBold
        alertLabel.textColor = .black
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        alertView.addSubview(alertLabel)
        
        blurView.alpha = 0
        
        setConstraints()
    }
    
    private func setConstraints() {
        blurView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        alertView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(20)
            make.width.equalTo(336 * screenWidthMultiplier)
            make.height.equalTo(58 * screenHeightMultiplier)
        }
        alertLabel.snp.makeConstraints { make in
            make.width.height.centerX.centerY.equalToSuperview()
        }
    }
    
    func present() {
        isUserInteractionEnabled = true
        alertView.snp.remakeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(336 * screenWidthMultiplier)
            make.height.equalTo(58 * screenHeightMultiplier)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            self.blurView.alpha = self.blurViewAlpha
        }
    }
    
    func dismiss() {
        isUserInteractionEnabled = false
        alertView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(20)
            make.width.equalTo(336 * screenWidthMultiplier)
            make.height.equalTo(58 * screenHeightMultiplier)
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            self.blurView.alpha = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
