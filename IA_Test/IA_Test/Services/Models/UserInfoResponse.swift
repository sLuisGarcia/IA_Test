//
//  UserInfoResponse.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

struct UserInfoResponse: Initable {
    var email: String
    var first_name: String
    var last_name: String
    var card_number: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case first_name
        case last_name
        case card_number
    }
    
    init() {
        email = ""
        first_name = ""
        last_name = ""
        card_number = ""
    }
}
