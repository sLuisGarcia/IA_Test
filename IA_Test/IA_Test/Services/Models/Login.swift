//
//  Login.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

struct LoginResponse: Initable {
    var access_token: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case access_token
        case username
    }
    
    init() {
        access_token = ""
        username = ""
    }
}

