//
//  Enviroment.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Foundation

public enum Enviroment {
    enum Keys {
        enum Plist {
            static let rootURL = "ROOT_URL"
            static let appName = "CFBundleName"
        }
    }

    private static let infoDictionary: [String: Any] = {
        guard let dic = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dic
    }()

    static let rootURL: URL = {
        guard let rootURLString = Enviroment.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let rootURL = URL(string: rootURLString) else {
            fatalError("Root URL is invalid")
        }
        return rootURL
    }()

    static let appName: String = {
        guard let appNameString = Enviroment.infoDictionary[Keys.Plist.appName] as? String else {
            fatalError("AppName not set in plist for this environment")
        }
        return appNameString
    }()
}
