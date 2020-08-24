//
//  EmojiSelectView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class EmojiSelectionViewController: UIViewController {

    // MARK: Subviews
    private lazy var promptLabel: UILabel = {
        let promptLabel = UILabel()
        promptLabel.text = "how are you feeling?"
        promptLabel.textColor = .black
        promptLabel.textAlignment = .center
        promptLabel.font = ._24DMSansBold
        return promptLabel
    }()
    
    private lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "select up to 5 emojis"
        instructionLabel.textColor = .lightGray
        instructionLabel.textAlignment = .center
        instructionLabel.font = ._14DMSansBold
        return instructionLabel
    }()
    
    private lazy var splashScreenInvisibleButton: UIButton = {
        let splashScreenInvisibleButton = UIButton()
        splashScreenInvisibleButton.backgroundColor = .clear
        splashScreenInvisibleButton.addTarget(self, action: #selector(animateSplash), for: .touchUpInside)
        return splashScreenInvisibleButton
    }()
    
    private lazy var emojiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 25 * widthMultiplier
        let emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.identifier)
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        emojiCollectionView.backgroundColor = .clear
        emojiCollectionView.isScrollEnabled = false  // true for debugging, false when finalized
        return emojiCollectionView
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setTitle("next", for: .normal)
        nextButton.titleLabel?.font = ._18DMSansBold
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = UIColor(white: 241/255, alpha: 1)
        nextButton.layer.cornerRadius = 15 * heightMultiplier
        nextButton.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        nextButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        nextButton.layer.shadowRadius = 10 * heightMultiplier
        nextButton.layer.shadowOpacity = 1
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return nextButton
    }()
    
    private lazy var alertView = AlertView()
    
    // MARK: Initialize & Layout
    
    private var completion: (() -> ())?
        
    init(completion: (() -> ())?) {
        super.init(nibName: nil, bundle: nil)
        self.completion = completion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(promptLabel)
        view.addSubview(instructionLabel)
        view.addSubview(splashScreenInvisibleButton)
        view.addSubview(emojiCollectionView)
        view.addSubview(nextButton)
        view.addSubview(alertView)
        
        instructionLabel.alpha = 0
        
        emojiCollectionView.alpha = 0
        emojiCollectionView.isUserInteractionEnabled = false
        
        nextButton.alpha = 0
        nextButton.isUserInteractionEnabled = false
        
        view.bringSubviewToFront(promptLabel)
        view.bringSubviewToFront(alertView)

        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
    }
    
    private func setConstraints() {
        let promptLabelHeight = 31 * heightMultiplier
        let collectionViewTopOffset = 106 * heightMultiplier
        let collectionViewBottomInset = 85 * heightMultiplier
        let nextButtonBottomInset = 23 * heightMultiplier
        let nextButtonWidth = 120 * widthMultiplier
        let nextButtonHeight = 30 * heightMultiplier
        
        promptLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(promptLabelHeight)
        }
        instructionLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(promptLabel)
        }
        splashScreenInvisibleButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        emojiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(collectionViewTopOffset)
            make.centerX.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(collectionViewBottomInset)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(nextButtonBottomInset)
            make.width.equalTo(nextButtonWidth)
            make.height.equalTo(nextButtonHeight)
        }
        alertView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc private func animateSplash() {
        promptLabel.snp.remakeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(31 * heightMultiplier)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(37 * heightMultiplier)
        }
        UIView.animate(withDuration: 0.25) {
            self.promptLabel.transform = self.promptLabel.transform.scaledBy(x: 20/24, y: 20/24)
            self.view.layoutIfNeeded()
            self.emojiCollectionView.alpha = 1
            self.nextButton.alpha = 1
        }
        emojiCollectionView.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
        splashScreenInvisibleButton.removeFromSuperview()
    }
    
    private func showInstructionLabel() {
        promptLabel.snp.remakeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(31 * heightMultiplier)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28 * heightMultiplier)
        }
        instructionLabel.snp.remakeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(61 * heightMultiplier)
            make.height.equalTo(18 * heightMultiplier)
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.instructionLabel.alpha = 1
        }
    }
    
    @objc private func nextButtonPressed() {
        if Emojis.selected.count == 0 {
            alertView.present(alertText: "‼️ please select at least one emoji")
        } else if Emojis.selected.count > 0 && Emojis.selected.count <= 5 {
            completion?()
        }
    }
}


extension EmojiSelectionViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section % 2 == 0 ? 4 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.identifier, for: indexPath) as! EmojiCollectionViewCell
        let emojiObject = Emojis.objects[getEmojiIndex(from: indexPath)]
        cell.configure(emojiObject: emojiObject)
        return cell
    }
    
    private func getEmojiIndex(from indexPath: IndexPath) -> Int {
        return indexPath.section / 2 * 7 + (indexPath.section % 2 == 0 ? 0 : 4) + indexPath.row
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
        let emojiObject = cell.emojiObject!
        let selected = Emojis.selected.contains(emojiObject)
        
        if Emojis.selected.count < 5 || selected {
            cell.setSelected(to: !selected)
            if selected {
                Emojis.selected.remove(emojiObject)
            } else {
                Emojis.selected.insert(emojiObject)
            }
        } else {
            alertView.present(alertText: "‼️ please select only up to 5 emojis")
            if instructionLabel.alpha == 0 {
                showInstructionLabel()
            }
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60 * heightMultiplier, height: 60 * heightMultiplier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let horizontalInsets: CGFloat = section % 2 == 0 ? 23 : 68
        let verticalInsets: CGFloat = 9
        return UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
    }
}
