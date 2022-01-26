//
//  Transactions.swift
//  IA_Test
//
//  Created by Luis García on 26/01/22.
//

import Foundation

struct TransactionsRequest: Initable {
    var card_number: String
    var pin: String
    var country_code: String
    var transaction_include: Bool
    
    enum CodingKeys: String, CodingKey {
        case card_number
        case pin
        case country_code
        case transaction_include
    }
    
    init() {
        card_number = ""
        pin = ""
        country_code = ""
        transaction_include = false
    }
    
    init(_ card_number: String, _ pin: String, _ country_code: String, _ transaction_include: Bool) {
        self.card_number = card_number
        self.pin = pin
        self.country_code = country_code
        self.transaction_include = transaction_include
    }
}

struct TransactionsResponse: Initable {
    var name: String
    var balance_list: [BalanceList]
    var level: Level
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case balance_list = "balance_list"
        case level = "level"
    }
    
    init() {
        name = ""
        balance_list = [BalanceList()]
        level = Level()
    }
}

struct BalanceList: Initable {
    var balance: Double
    var key: String
    var name: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case balance = "balance"
        case key = "key"
        case name = "name"
        case message = "message"
    }
    
    init() {
        balance = 0.0
        key = ""
        name = ""
        message = ""
    }
}

struct Level: Initable {
    var next_level: String
    var advance_percent: Double
    var name: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case next_level = "next_level"
        case advance_percent = "advance_percent"
        case name = "name"
        case message = "message"
    }
    
    init() {
        next_level = ""
        advance_percent = 0.0
        name = ""
        message = ""
    }
}
