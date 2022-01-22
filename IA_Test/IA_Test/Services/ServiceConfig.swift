//
//  ServiceConfig.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation


public final class ServiceConfig: CustomStringConvertible {
    private static let ENDPOINT = "Endpoint"
    private static let NAME = "name"
    private static let URL_ = "url"

    public var description: String {
        return "\(name): \(url.absoluteString)"
    }

    private(set) var name: String
    private(set) var url: URL
    private(set) var headers: [String: String] = [:]
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    public var timeout: TimeInterval = 15.0

    public init?(name: String, url: String) {
        guard let _url = URL(string: url) else { return nil }
        self.url = _url
        self.name = name
    }

    public init(name: String, url: URL) {
        self.url = url
        self.name = name
    }

    public convenience init() {
        self.init(name: Enviroment.appName, url: Enviroment.rootURL)
    }

    public static func appConfig() -> ServiceConfig {
        return ServiceConfig()
    }
}
