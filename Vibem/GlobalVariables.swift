//
//  GlobalVariables.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/27/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import UIKit

// MARK: Testing
let testing: Bool = true

// MARK: Relative Screen Constants
let widthMultiplier: CGFloat = UIScreen.main.bounds.width / 375
let heightMultiplier: CGFloat = UIScreen.main.bounds.height / 812

// MARK: UserDefaults
let userDefaults = UserDefaults.standard

// MARK: Spotify Auth
let clientID = "78ce7ecf29e84f9197bd9a9c80843618"
let redirectURLString = "gpo-vibem://spotify-login-callback"
let tokenSwapURLString = "https://gpo-vibem.herokuapp.com/api/token"
let tokenRefreshURLString = "https://gpo-vibem.herokuapp.com/api/refresh_token"
var config: SPTConfiguration = {
    let callMeMaybe = "spotify:track:20I6sIOMTCkB6w7ryavxtO"
    let scope: SPTScope = [
        .userFollowRead
    ]
    let config = SPTConfiguration(clientID: clientID, redirectURL: URL(string: redirectURLString)!)
    config.playURI = callMeMaybe
    config.tokenSwapURL = URL(string: tokenSwapURLString)!
    config.tokenRefreshURL = URL(string: tokenRefreshURLString)!
    return config
}()

var sessionManager: SPTSessionManager = {
    let manager = SPTSessionManager(configuration: config, delegate: RootViewController.shared.authVC)
    manager.alwaysShowAuthorizationDialog = false
    return manager
}()
