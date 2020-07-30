//
//  User.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/29/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import Foundation

class User: Codable {
    var _id: String!
    var name: String!
    
    
    init(_id: String, name: String) {
        self._id = _id
        self.name = name
    }
}

