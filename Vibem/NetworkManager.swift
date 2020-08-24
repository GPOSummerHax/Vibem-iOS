//
//  NetworkManager.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/22/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static func getDisplayName(accessToken: String, completion: @escaping ((String) -> ())) {
        let endpoint: String = "https://api.spotify.com/v1/me"
        let headers = HTTPHeaders([
            "Authorization" : "Bearer " + accessToken
        ])
        let parameters: [String: String]? = nil
        
        AF.request(
            endpoint,
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        ).responseData { (response) in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                guard let name = json["display_name"].string else { return }
                completion(name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func renewSession(completion: @escaping ((Bool) -> ())) {
        let refreshToken = userDefaults.string(forKey: UserDefaultsKeys.refreshToken) ?? ""
        let parameters: [String : String] = [
            "refresh_token" : refreshToken
        ]
        AF.request(
            tokenRefreshURLString,
            method: .post,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: nil
        ).responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                if let _ = json["error"].string {
                    completion(false)
                } else {
                    guard let accessToken = json["access_token"].string else { return }
                    userDefaults.setValue(accessToken, forKey: UserDefaultsKeys.accessToken)
                    print(json)
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getTestPlaylist() {
        let accessToken = userDefaults.string(forKey: UserDefaultsKeys.accessToken) ?? ""
        let parameters: [String: String] = [
            "access_token" : accessToken
        ]
        AF.request(
            "https://vibem-4dca1.web.app/playlist",
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: nil
        ).responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
