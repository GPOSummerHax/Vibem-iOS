//
//  AuthViewController.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/22/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, SPTSessionManagerDelegate {

    // MARK: Layout Constants
    private let loginButtonWidth = 120 * widthMultiplier
    private let loginButtonHeight = 30 * heightMultiplier
    private let infoLabelTopOffset = 30 * heightMultiplier
    
    // MARK: Subviews
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Connect", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setBackgroundImage(UIColor.spotifyGreen.image(), for: .normal)
        loginButton.layer.cornerRadius = loginButtonHeight / 2
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        infoLabel.text = "not logged in yet"
        return infoLabel
    }()
    
    // MARK: Initialize View
    var completion: (() -> ())?
    
    init(completion: (() -> ())?) {
        super.init(nibName: nil, bundle: nil)
        self.completion = completion
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        view.addSubview(infoLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        loginButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(loginButtonWidth)
            make.height.equalTo(loginButtonHeight)
        }
        infoLabel.snp.makeConstraints { make in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(infoLabelTopOffset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SPT Config
    private let clientID = "78ce7ecf29e84f9197bd9a9c80843618"
    private let redirectURLString = "gpo-vibem://spotify-login-callback"
    private let tokenSwapURLString = "https://gpo-vibem.herokuapp.com/api/token"
    private let tokenRefreshURLString = "https://gpo-vibem.herokuapp.com/api/refresh_token"
    private let callMeMaybe = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
    private let scope: SPTScope = [
        .userFollowRead
    ]
    private var refreshTimer: Timer?
    
    private lazy var config: SPTConfiguration = {
        let config = SPTConfiguration(clientID: clientID, redirectURL: URL(string: redirectURLString)!)
        config.playURI = callMeMaybe
        config.tokenSwapURL = URL(string: tokenSwapURLString)!
        config.tokenRefreshURL = URL(string: tokenRefreshURLString)!
        return config
    }()

    internal lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: config, delegate: self)
        manager.alwaysShowAuthorizationDialog = false
        return manager
    }()

    // MARK: SPTSessionManagerDelegate
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        // this is the completion function that's called when the initiation session is validated
        refreshTimer?.invalidate()
        DispatchQueue.main.async {
            self.refreshTimer = Timer.scheduledTimer(withTimeInterval: 3598, repeats: false, block: { (timer) in
                self.sessionManager.renewSession()
            })
        }
        spotifySessionManager = sessionManager
        NetworkManager.getDisplayName(accessToken: session.accessToken) { displayName in
            self.infoLabel.text = "logged in as: \(displayName)"
            testUser = User(_id: "", name: displayName)
            self.completion?()
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
        DispatchQueue.main.async {
            self.refreshTimer = Timer.scheduledTimer(withTimeInterval: 3598, repeats: false, block: { (timer) in
                self.sessionManager.renewSession()
            })
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
    }
    
    // MARK: Actions
    @objc private func loginButtonTapped() {
        let scope: SPTScope = [.userFollowRead]
        sessionManager.initiateSession(with: scope, options: .default)
    }
    
    private func presentAlertController(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true)
        }
    }
}
