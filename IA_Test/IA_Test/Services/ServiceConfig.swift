//
//  ServiceConfig.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

/// Service configuration data representation.
public final class ServiceConfig: CustomStringConvertible {
    /// Key for global endpoint data.
    private static let ENDPOINT = "Endpoint"
    /// Key for endpoint name.
    private static let NAME = "name"
    /// Key for endpoint url.
    private static let URL_ = "url"

    public var description: String {
        return "\(name): \(url.absoluteString)"
    }

    /// Service endpoint name.
    private(set) var name: String
    /// Service endpoint url.
    private(set) var url: URL
    /// Service headers. Default is empty.
    private(set) var headers: [String: String] = [:]
    /// Service cache type. Default is `.useProtocolCachePolicy`
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    /// Service timeout interval. Default is `15.0`
    public var timeout: TimeInterval = 15.0

    /// Initializer for custom endpoint.
    ///
    /// - Parameters:
    ///   - name: Endpoint interpretable name.
    ///   - url: Endpoint url text representation.
    public init?(name: String, url: String) {
        guard let _url = URL(string: url) else { return nil }
        self.url = _url
        self.name = name
    }

    /// Initializer for custom endpoint.
    ///
    /// - Parameters:
    ///   - name: Endpoint interpretable name.
    ///   - url: Endpoint url object
    public init(name: String, url: URL) {
        self.url = url
        self.name = name
    }

    /// Initializer for global Endpoint config
    /// defined in `Info.plist` file
    public convenience init() {
        self.init(name: Enviroment.appName, url: Enviroment.rootURL)
    }

    /// Shared ServiceConfig instance
    ///
    /// - Returns: ServiceConfig object
    public static func appConfig() -> ServiceConfig {
        return ServiceConfig()
    }
}
