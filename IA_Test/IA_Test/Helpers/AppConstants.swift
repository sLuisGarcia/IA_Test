//
//  AppConstants.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

enum AppColors {
    static let baseBlue     = UIColor(hex: "7693E4")
    static let lightBlue    = UIColor(hex: "AFC6F6")
    static let darkBlue     = UIColor(hex: "253684")
    static let baseGray     = UIColor(hex: "ADB0B8")
    static let darkGray     = UIColor(hex: "576084")
    static let baseRed      = UIColor(hex: "B7808A")
    static let white        = UIColor(hex: "FFFFFF")
}

enum AppConstraints {
    static let paddingZero: CGFloat      = 0
    static let padding8: CGFloat         = 8
    static let padding12: CGFloat       = 12
    static let padding16: CGFloat       = 16
    static let padding20: CGFloat       = 20
    static let padding24: CGFloat       = 24
    static let padding32: CGFloat       = 32
    static let heightButton: CGFloat    = 56
}

enum FontType {
    case regular, bold
}

public struct AppUtils {
    static func font(_ type: FontType, _ size: CGFloat) -> UIFont {
        let fontName = (type == .regular) ? "Poppins-Regular" : "Poppins-Bold"
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        return UIFont()
    }
    
    static func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}

enum ButtonStatus {
    case active, inactive, regular
}
