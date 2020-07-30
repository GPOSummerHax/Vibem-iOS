//
//  EmojiConfirmationView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class EmojiConfirmationViewController: UIViewController {

    private var completion: (() -> ())?
    
    private let backButton = UIButton()
    private let promptLabel = UILabel()
    private let emojiTableView = UITableView()
    private var emojiData: [(Character, UIColor)]!
    
    private let confirmButton = UIButton()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func configure(emojiData: [(Character, UIColor)], completion: (() -> ())? = nil) {
        self.emojiData = emojiData
        self.completion = completion
        
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.titleLabel?.font = ._18DMSansBold
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        promptLabel.text = "\(testUser.name!), you picked these \(emojiData.count) emojis: "
        promptLabel.textColor = .black
        promptLabel.font = ._20DMSansBold
        promptLabel.numberOfLines = 0
        promptLabel.textAlignment = .center
        view.addSubview(promptLabel)
        
        emojiTableView.delegate = self
        emojiTableView.dataSource = self
        emojiTableView.register(EmojiConfirmationTableViewCell.self, forCellReuseIdentifier: EmojiConfirmationTableViewCell.identifier)
        emojiTableView.tableFooterView = UIView()
        emojiTableView.allowsSelection = false
        emojiTableView.isScrollEnabled = false
        view.addSubview(emojiTableView)
        emojiTableView.reloadData()
        
        confirmButton.setTitle("make your playlist", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setTitleColor(.gray, for: .selected)
        confirmButton.titleLabel?.font = ._18DMSansBold
        confirmButton.backgroundColor = UIColor(white: 241/255, alpha: 1)
        confirmButton.layer.cornerRadius = 15 * screenHeightMultiplier
        confirmButton.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        confirmButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        confirmButton.layer.shadowRadius = 10 * screenHeightMultiplier
        confirmButton.layer.shadowOpacity = 1
        view.addSubview(confirmButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(15 * screenHeightMultiplier)
        }
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets).offset(85 * screenHeightMultiplier)
            make.width.equalTo(300 * screenWidthMultiplier)
        }
        emojiTableView.snp.makeConstraints { make in
            let sideInset: CGFloat = 25 * screenWidthMultiplier
            make.trailing.leading.equalToSuperview().inset(sideInset)
            make.top.equalTo(promptLabel.snp.bottom).offset(25 * screenHeightMultiplier)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30 * screenHeightMultiplier)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(23 * screenHeightMultiplier)
            make.width.equalTo(200 * screenWidthMultiplier)
            make.height.equalTo(30 * screenHeightMultiplier)
        }
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
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
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    // MARK: UITableViewDelegate
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * screenHeightMultiplier
    }
}
