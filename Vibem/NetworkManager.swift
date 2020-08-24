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
}
