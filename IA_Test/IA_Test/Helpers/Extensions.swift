//
//  Extensions.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let redColor = (rgbValue & 0xff0000) >> 16
        let greenColor = (rgbValue & 0xff00) >> 8
        let blueColor = rgbValue & 0xff

        self.init(
            red: CGFloat(redColor) / 0xff,
            green: CGFloat(greenColor) / 0xff,
            blue: CGFloat(blueColor) / 0xff, alpha: 1
        )
    }
}

extension UIViewController {
    func topColouredView(color: UIColor) {
        let colouredTop = UIView()
        view.addSubview(colouredTop)
        colouredTop.translatesAutoresizingMaskIntoConstraints = false
        colouredTop.backgroundColor = color
        
        NSLayoutConstraint.activate([
            colouredTop.topAnchor.constraint(equalTo: view.topAnchor),
            colouredTop.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colouredTop.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
