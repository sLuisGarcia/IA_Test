//
//  Request.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Alamofire

class Request {
    /// Request Http method.
    public var method: Alamofire.HTTPMethod
    /// Request service path.
    public var path: String
    /// Request parametters. Default is `nil`.
    public var parameters: [String: Any]?
    /// Request encoding type. Default `.default`.
    public var encoding: ParameterEncoding = URLEncoding.default
    /// Request http headers. Default is `nil`.
    public var headers: [String: String]?

    /// Service request object data.
    ///
    /// - Parameters:
    ///   - method: Http method object.
    ///   - path: Service path.
    ///   - parameters: Service dictionary parametters.
    ///   - encoding: URL encoding type.
    ///   - headers: Http dictionary headers.
    required init(method: Alamofire.HTTPMethod, path: String, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
}
