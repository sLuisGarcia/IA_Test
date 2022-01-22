//
//  EncodeUtils.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

enum EncodeUtilsErrors: Error {
    case cantDecodeString
    case cantDecodeData
}

struct EncodeUtils {
    func getJSONString<T>(from: T) throws -> String where T: Encodable {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(from)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw EncodeUtilsErrors.cantDecodeString
        }
        return jsonString
    }

    func get<T>(_: T.Type, from json: String) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            throw EncodeUtilsErrors.cantDecodeData
        }
        let object = try jsonDecoder.decode(T.self, from: data)
        return object
    }

    func get<T>(_: T.Type, from data: Data) throws -> T where T: Decodable {
        let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(T.self, from: data)
        return object
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
