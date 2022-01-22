//
//  AppManager.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class AppManager {
    
    let data = UserDefaults.standard
    public static let accessToken: String! = "accessToken"
    
    func getStringData(sessionName: String) -> String {
        return data.string(forKey: sessionName) ?? ""
    }

    func setStringData(sessionName: String, sessionValue: String) {
        data.set(sessionValue, forKey: sessionName)
    }
}

extension AppManager {
    func showAlert(_ context: UIViewController, _ title: String, _ message: String, _ okText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: okText, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        context.present(alert, animated: true, completion: nil)
    }
}
