//
//  HeaderFactory.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class HeaderFactory {
    private enum HeaderKeys {
        static let api_key = "api_key"
        static let contentType = "Content-Type"
        static let Authorization = "Authorization"
        static let country_code = "country_code"
        static let username = "username"
        static let password = "password"
        static let grant_type = "grant_type"
        static let client_id = "client_id"
        static let client_secret = "client_secret"
    }
    // TODO: - Change when header documentation is available.
    class func getLoginHeaders() -> [String: String] {
        let headers = [HeaderKeys.api_key: "stage_HNYh3RaK_Test",
                       HeaderKeys.contentType: "application/x-www-form-urlencoded"]
        return headers
    }
    
    class func getLoginParams(_ username: String, _ password: String) -> [String: String] {
        let params = [HeaderKeys.country_code: "MX",
                       HeaderKeys.username: username,
                       HeaderKeys.password: password,
                       HeaderKeys.grant_type: "password",
                       HeaderKeys.client_id: "IATestCandidate",
                       HeaderKeys.client_secret: "c840457e777b4fee9b510fbcd4985b68"]
        return params
    }
    
    class func getBaseHeaders() -> [String: String] {
        let headers = [HeaderKeys.contentType: "application/json",
                       HeaderKeys.api_key: "stage_HNYh3RaK_Test"]
        return headers
    }

    class func getAuthHeaders(_ accessToken: String) -> [String: String] {
        let headers = [HeaderKeys.contentType: "application/json",
                       HeaderKeys.api_key: "stage_HNYh3RaK_Test",
                       HeaderKeys.Authorization : "Bearer \(accessToken)"]
        return headers
    }
}
