//
//  EmojiConfirmationView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class EmojiConfirmationViewController: UIView {

    private let promptLabel = UILabel()
    private let emojiTableView = UITableView()
    private var emojiData: [(Character, UIColor)]!
    
    private let confirmButton = UIButton()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    func configure(emojiData: [(Character, UIColor)]) {
        self.emojiData = emojiData
        
        promptLabel.text = "\(testUser.name!), you picked these \(emojiData.count) emojis: "
        promptLabel.textColor = .black
        promptLabel.font = ._24DMSansBold
        promptLabel.numberOfLines = 0
        addSubview(promptLabel)
        
        emojiTableView.delegate = self
        emojiTableView.dataSource = self
        emojiTableView.register(EmojiConfirmationTableViewCell.self, forCellReuseIdentifier: EmojiConfirmationTableViewCell.identifier)
        let sideInset: CGFloat = 25 * screenWidthMultiplier
        emojiTableView.contentInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: -sideInset)
        emojiTableView.tableFooterView = UIView()
        emojiTableView.allowsSelection = false
        emojiTableView.isScrollEnabled = false
        addSubview(emojiTableView)
        
        confirmButton.setTitle("Make Your Playlist", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.titleLabel?.font = ._18DMSansBold
        confirmButton.backgroundColor = UIColor(white: 241/255, alpha: 1)
        confirmButton.layer.cornerRadius = 15 * screenHeightMultiplier
        confirmButton.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        confirmButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        confirmButton.layer.shadowRadius = 10 * screenHeightMultiplier
        confirmButton.layer.shadowOpacity = 1
        addSubview(confirmButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaInsets).offset(50 * screenHeightMultiplier)
            make.width.equalTo(300 * screenWidthMultiplier)
        }
        emojiTableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(promptLabel.snp.bottom).offset(25 * screenHeightMultiplier)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(30 * screenHeightMultiplier)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(23 * screenHeightMultiplier)
            make.width.equalTo(200 * screenWidthMultiplier)
            make.height.equalTo(30 * screenHeightMultiplier)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmojiConfirmationViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmojiConfirmationTableViewCell.identifier, for: indexPath) as! EmojiConfirmationTableViewCell
        let data = emojiData[indexPath.row]
        cell.configure(emoji: data.0, backgroundColor: data.1, emojiDescription: "ryan got a cute ass")
        return cell
    }
    
    // MARK: UITableViewDelegate
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125 * screenHeightMultiplier
    }
}
