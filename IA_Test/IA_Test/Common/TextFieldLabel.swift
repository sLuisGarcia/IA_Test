//
//  TextFieldLabel.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit
import JVFloatLabeledTextField

class TextFieldLabel: UIView {
    
    let textField: JVFloatLabeledTextField = {
        let txt = JVFloatLabeledTextField(frame: .zero)
        txt.font = AppUtils.font(.regular, 16)
        txt.textColor = AppColors.darkBlue
        txt.borderStyle = .roundedRect
        txt.layer.borderColor = AppColors.baseGray.cgColor
        txt.layer.borderWidth = 1.0
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initUI() {
        addSubview(textField)
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

extension TextFieldLabel {    
    func getText() -> String {
        return self.textField.text ?? ""
    }
}
