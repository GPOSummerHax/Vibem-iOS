//
//  EmojiSelectView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit
import SnapKit

class EmojiSelectView: UIView {

    private let promptLabel = UILabel()
    private let instructionLabel = UILabel()
    private let splashScreenInvisibleButton = UIButton()
    
    private var emojiCollectionView: UICollectionView!
    private var emojiData: [[(Character, Bool, UIColor)]] = [ // triple (emoji, selected, backgroundColor)
        [("😗", false, UIColor(hexCode: "#FFD94EFF")!), ("🎉", false, UIColor(hexCode: "#DDDF8BFF")!), ("🔮", false, UIColor(hexCode: "#F7C0FAFF")!), ("🔥", false, UIColor(hexCode: "#FFA40DFF")!)],
        [("😔", false, UIColor(hexCode: "#DE7AD4FF")!), ("😈", false, UIColor(hexCode: "#DEA1EBFF")!), ("🤡", false, UIColor(hexCode: "#E77B6DFF")!)],
        [("😇", false, UIColor(hexCode: "#5BAAFFFF")!), ("😎", false, UIColor(hexCode: "#DFC729FF")!), ("😱", false, UIColor(hexCode: "#CCD5FBFF")!), ("😴", false, UIColor(hexCode: "#CDD0D5FF")!)],
        [("😻", false, UIColor(hexCode: "#FFF68DFF")!), ("👑", false, UIColor(hexCode: "#EDA8D0FF")!), ("🙈", false, UIColor(hexCode: "#E7DABCFF")!)],
        [("🌿", false, UIColor(hexCode: "#87D333FF")!), ("😡", false, UIColor(hexCode: "#FECA69FF")!), ("🙌", false, UIColor(hexCode: "#74E980FF")!), ("🙄", false, UIColor(hexCode: "#FFCC91FF")!)],
        [("✌️", false, UIColor(hexCode: "#D3E4FDFF")!), ("😒", false, UIColor(hexCode: "#FDF5CAFF")!), ("😜", false, UIColor(hexCode: "#FFEA3AFF")!)],
        [("😣", false, UIColor(hexCode: "#EF97E6FF")!), ("😭", false, UIColor(hexCode: "#C0C0C0FF")!), ("☀️", false, UIColor(hexCode: "#FFFB99FF")!), ("🤓", false, UIColor(hexCode: "#B5D0DFFF")!)]
    ]
    private var selectedEmojis: [Character] = []
    
    private let nextButton = UIButton()
    
    private let alertView = AlertView(alertText: "‼️ please select only up to 5 emojis")
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white // for initial test
        
        promptLabel.text = "how are you feeling?"
        promptLabel.textColor = .black
        promptLabel.textAlignment = .center
        promptLabel.font = ._24DMSansBold
        addSubview(promptLabel)
        
        instructionLabel.text = "select up to 5 emojis"
        instructionLabel.textColor = .lightGray
        instructionLabel.textAlignment = .center
        instructionLabel.font = ._14DMSansBold
        addSubview(instructionLabel)
        instructionLabel.alpha = 0
        
        splashScreenInvisibleButton.backgroundColor = .clear
        splashScreenInvisibleButton.addTarget(self, action: #selector(animateSplash), for: .touchUpInside)
        addSubview(splashScreenInvisibleButton)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 30 * screenWidthMultiplier
        layout.minimumLineSpacing = 18 * screenHeightMultiplier
        emojiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        emojiCollectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.identifier)
        emojiCollectionView.dataSource = self
        emojiCollectionView.delegate = self
        emojiCollectionView.backgroundColor = .clear
        emojiCollectionView.isScrollEnabled = true // true for debugging, false when finalized
        addSubview(emojiCollectionView)
        emojiCollectionView.alpha = 0
        emojiCollectionView.isUserInteractionEnabled = false
        
        nextButton.setTitle("next", for: .normal)
        nextButton.titleLabel?.font = ._18DMSansBold
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = UIColor(white: 241/255, alpha: 1)
        nextButton.layer.cornerRadius = 15 * screenHeightMultiplier
        nextButton.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        nextButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        nextButton.layer.shadowRadius = 10 * screenHeightMultiplier
        nextButton.layer.shadowOpacity = 1
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        addSubview(nextButton)
        nextButton.alpha = 0
        nextButton.isUserInteractionEnabled = false
        
        addSubview(alertView)
        
        bringSubviewToFront(promptLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        promptLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.equalToSuperview()
            make.height.equalTo(31 * screenHeightMultiplier)
        }
        instructionLabel.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(promptLabel)
        }
        splashScreenInvisibleButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        emojiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(106 * screenHeightMultiplier)
            make.centerX.width.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(100 * screenHeightMultiplier)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(23 * screenHeightMultiplier)
            make.width.equalTo(120 * screenWidthMultiplier)
            make.height.equalTo(30 * screenHeightMultiplier)
        }
        alertView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func animateSplash() {
        promptLabel.snp.remakeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.height.equalTo(31 * screenHeightMultiplier)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(37 * screenHeightMultiplier)
        }
        UIView.animate(withDuration: 0.5) {
            self.promptLabel.transform = self.promptLabel.transform.scaledBy(x: 20/24, y: 20/24)
            self.layoutIfNeeded()
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
            make.height.equalTo(31 * screenHeightMultiplier)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(28 * screenHeightMultiplier)
        }
        instructionLabel.snp.remakeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(61 * screenHeightMultiplier)
            make.height.equalTo(18 * screenHeightMultiplier)
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            self.instructionLabel.alpha = 1
        }
    }
    
    private func updateSelectedEmojis() {
        let flattened = emojiData.reduce([], +)
        selectedEmojis.removeAll()
        for data in flattened {
            if data.1 {
                selectedEmojis.append(data.0)
            }
        }
    }
    
    @objc private func nextButtonPressed() {
        print(selectedEmojis)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension EmojiSelectView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section % 2 == 0 ? 4 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.identifier, for: indexPath) as! EmojiCollectionViewCell
        let data = emojiData[indexPath.section][indexPath.row]
        cell.configure(emoji: data.0, backgroundColor: data.2)
        if data.1 {
            cell.toggleSelected()
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedEmojis.count < 5 || emojiData[indexPath.section][indexPath.row].1 {
            let cell = collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
            cell.toggleSelected()
            emojiData[indexPath.section][indexPath.row].1.toggle()
            updateSelectedEmojis()
        } else {
            alertView.present()
            if instructionLabel.alpha == 0 {
                showInstructionLabel()
            }
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60 * screenHeightMultiplier, height: 60 * screenHeightMultiplier)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let horizontalInsets: CGFloat = section % 2 == 0 ? 23 : 68
        let verticalInsets: CGFloat = 9
        return UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
    }
}
