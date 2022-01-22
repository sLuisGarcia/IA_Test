//
//  LoginView.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

// MARK: - View Delegate
protocol LoginViewDelegate: AnyObject {
    func validateLogin(_ username: String, _ password: String)
}

class LoginView: UIView {
    
    // MARK: - Variable declaration
    private weak var delegate: LoginViewDelegate?
    
    // MARK: - View declaration
    private let txtUsernmae: TextFieldLabel = {
        let txt = TextFieldLabel(frame: .zero)
        txt.textField.setPlaceholder("Usuario", floatingTitle: "Usuario")
        txt.textField.floatingLabelTextColor = AppColors.baseGray
        txt.textField.floatingLabelActiveTextColor = AppColors.baseGray
        txt.textField.placeholderColor = AppColors.baseGray
        txt.textField.floatingLabelYPadding = 5
        txt.textField.keyboardType = .emailAddress
        txt.textField.backgroundColor = AppColors.white
        return txt
    }()
    
    private let txtPassword: TextFieldLabel = {
        let txt = TextFieldLabel(frame: .zero)
        txt.textField.setPlaceholder("Contraseña", floatingTitle: "Contraseña")
        txt.textField.floatingLabelTextColor = AppColors.baseGray
        txt.textField.floatingLabelActiveTextColor = AppColors.baseGray
        txt.textField.placeholderColor = AppColors.baseGray
        txt.textField.floatingLabelYPadding = 5
        txt.textField.keyboardType = .asciiCapable
        txt.textField.backgroundColor = AppColors.white
        txt.textField.isSecureTextEntry = true
        return txt
    }()
    
    private let buttonPrimary: ButtonPrimary = {
        let img = ButtonPrimary(frame: .zero)
        return img
    }()
    
    // MARK: - Override Methods
    init(frame: CGRect, delegate: LoginViewDelegate) {
        self.delegate = delegate
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializers
    internal func initUI() {
        initViews()
        initStrings()
        initConstraints()
    }
    
    // MARK: - Add subviews
    internal func initViews() {
        addSubview(txtUsernmae)
        addSubview(txtPassword)
        addSubview(buttonPrimary)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        buttonPrimary.setButtonStyle("Iniciar sesión", .active)
    }
    
    // MARK: - Add Constraints
    internal func initConstraints() {
        self.txtUsernmae.translatesAutoresizingMaskIntoConstraints = false
        self.txtPassword.translatesAutoresizingMaskIntoConstraints = false
        self.buttonPrimary.translatesAutoresizingMaskIntoConstraints = false
        self.buttonPrimary.delegate = self
        NSLayoutConstraint.activate([
            txtUsernmae.bottomAnchor.constraint(equalTo: txtPassword.topAnchor, constant: -24),
            txtUsernmae.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            txtUsernmae.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            txtUsernmae.heightAnchor.constraint(equalToConstant: 56),
            
            txtPassword.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            txtPassword.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            txtPassword.heightAnchor.constraint(equalToConstant: 56),
            txtPassword.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            buttonPrimary.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 32),
            buttonPrimary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            buttonPrimary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            buttonPrimary.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

// MARK: - Button Primary Method
extension LoginView: ButtonPrimaryDelegate {
    func didClickButton(index: Int) {
        let username = self.txtUsernmae.getText()
        let password = self.txtPassword.getText()
        self.delegate?.validateLogin(username, password)
    }
}
