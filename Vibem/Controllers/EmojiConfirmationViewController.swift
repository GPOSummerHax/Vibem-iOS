//
//  EmojiConfirmationView.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class EmojiConfirmationViewController: UIViewController {
    
    // MARK: Subviews
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.gray, for: .normal)
        backButton.titleLabel?.font = ._18DMSansBold
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var promptLabel: UILabel = {
        let promptLabel = UILabel()
        promptLabel.text = promptLabelText
        promptLabel.textColor = .black
        promptLabel.font = ._20DMSansBold
        promptLabel.numberOfLines = 0
        promptLabel.textAlignment = .center
        return promptLabel
    }()
    
    private lazy var emojiTableView: UITableView = {
        let emojiTableView = UITableView()
        emojiTableView.backgroundColor = .white
        emojiTableView.delegate = self
        emojiTableView.dataSource = self
        emojiTableView.register(EmojiConfirmationTableViewCell.self, forCellReuseIdentifier: EmojiConfirmationTableViewCell.identifier)
        emojiTableView.tableFooterView = UIView()
        emojiTableView.allowsSelection = false
        emojiTableView.isScrollEnabled = false
        return emojiTableView
    }()
    
    private lazy var confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.setTitle("make your playlist", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setTitleColor(.gray, for: .selected)
        confirmButton.titleLabel?.font = ._18DMSansBold
        confirmButton.backgroundColor = UIColor(white: 241/255, alpha: 1)
        confirmButton.layer.cornerRadius = 15 * heightMultiplier
        confirmButton.layer.shadowColor = UIColor(white: 0, alpha: 0.15).cgColor
        confirmButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        confirmButton.layer.shadowRadius = 10 * heightMultiplier
        confirmButton.layer.shadowOpacity = 1
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return confirmButton
    }()
    
    private lazy var loadingAnimationView: LoadingAnimationView = {
        let loadingAnimationView = LoadingAnimationView()
        loadingAnimationView.frame = view.frame
        return loadingAnimationView
    }()
    
    // MARK: Computed Vars
    private var promptLabelText: String {
        get {
            let isPlural = Emojis.selected.count != 1
            let thisThese = isPlural ? "these" : "this"
            let emojiPlural = isPlural ? "emojis" : "emoji"
            return "\(testUser.name!), you picked \(thisThese) \(Emojis.selected.count) \(emojiPlural): "
        }
    }
    
    // MARK: Initialize & Layout
    
    private var completion: (() -> ())?
        
    init(completion: (() -> ())?) {
        super.init(nibName: nil, bundle: nil)
        self.completion = completion
        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(promptLabel)
        view.addSubview(emojiTableView)
        view.addSubview(confirmButton)
        view.addSubview(loadingAnimationView)
        
        emojiTableView.reloadData()
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emojiTableView.reloadData()
        promptLabel.text = promptLabelText
        view.layoutIfNeeded()
    }
    
    private func setConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(15 * heightMultiplier)
        }
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets).offset(85 * heightMultiplier)
            make.width.equalTo(300 * widthMultiplier)
        }
        emojiTableView.snp.makeConstraints { make in
            let sideInset: CGFloat = 25 * widthMultiplier
            make.trailing.leading.equalToSuperview().inset(sideInset)
            make.top.equalTo(promptLabel.snp.bottom).offset(25 * heightMultiplier)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30 * heightMultiplier)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(23 * heightMultiplier)
            make.width.equalTo(200 * widthMultiplier)
            make.height.equalTo(30 * heightMultiplier)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func confirmButtonTapped() {
        loadingAnimationView.present()
    }
}

extension EmojiConfirmationViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Emojis.selected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmojiConfirmationTableViewCell.identifier, for: indexPath) as! EmojiConfirmationTableViewCell
        let emojiObject = Array(Emojis.selected)[indexPath.row]
        cell.configure(emojiObject: emojiObject)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    // MARK: UITableViewDelegate
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * heightMultiplier
    }
}
