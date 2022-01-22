//
//  ProfileView.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

// MARK: - View Delegate
protocol ProfileViewDelegate: AnyObject {
    func nextTab(_ index: Int)
}

class ProfileView: UIView {
    
    // MARK: - Variable declaration
    private weak var delegate: ProfileViewDelegate?
    private let userInfo: UserInfoResponse
    
    // MARK: - View declaration
    private let navBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColors.baseBlue
        return view
    }()
    private let lblProfile: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 20)
        lbl.textColor = AppColors.white
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let imgProfile: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let lblUsername: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblEmail: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblCardNumber: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let appNavBar: AppNavBar = {
        let navbar = AppNavBar(frame: .zero)
        return navbar
    }()
    
    // MARK: - Override Methods
    init(frame: CGRect, delegate: ProfileViewDelegate, userInfo: UserInfoResponse) {
        self.delegate = delegate
        self.userInfo = userInfo
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
        addSubview(navBar)
        addSubview(lblProfile)
        addSubview(imgProfile)
        addSubview(lblUsername)
        addSubview(lblEmail)
        addSubview(lblCardNumber)
        addSubview(appNavBar)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        self.imgProfile.image = UIImage(named: "profile")
        self.lblProfile.text = "Perfil"
        
        var bodyString = "Bienvenido: \n\(self.userInfo.first_name) \(self.userInfo.last_name)"
        var range = (bodyString as NSString).range(of: "Bienvenido:")
        var attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 16),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblUsername.attributedText = attrStr
        
        bodyString = "Correo electrónico: \n\(self.userInfo.email)"
        range = (bodyString as NSString).range(of: "Correo electrónico:")
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 16),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblEmail.attributedText = attrStr
        
        bodyString = "Tarjeta: \(self.userInfo.card_number)"
        range = (bodyString as NSString).range(of: "Tarjeta:")
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 16),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblCardNumber.attributedText = attrStr
        self.appNavBar.configureBar(0)
    }
    
    // MARK: - Add Constraints
    internal func initConstraints() {
        initHeaderConstraints()
        initDataConstraints()
        initBottomNavbarConstraints()
    }
    
    // MARK: - Configure Views
    internal func initHeaderConstraints() {
        self.navBar.translatesAutoresizingMaskIntoConstraints = false
        self.lblProfile.translatesAutoresizingMaskIntoConstraints = false
        self.imgProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: AppConstraints.paddingZero),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            navBar.heightAnchor.constraint(equalToConstant: AppConstraints.heightButton),
            
            lblProfile.topAnchor.constraint(equalTo: navBar.centerYAnchor),
            lblProfile.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblProfile.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            imgProfile.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: AppConstraints.padding16),
            imgProfile.widthAnchor.constraint(equalToConstant: AppConstraints.heightButton),
            imgProfile.heightAnchor.constraint(equalToConstant: AppConstraints.heightButton),
            imgProfile.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    internal func initDataConstraints() {
        self.lblUsername.translatesAutoresizingMaskIntoConstraints = false
        self.lblEmail.translatesAutoresizingMaskIntoConstraints = false
        self.lblCardNumber.translatesAutoresizingMaskIntoConstraints = false
        let heightUser = AppUtils.heightForView(text: lblUsername.text ?? "",
                                                font: lblUsername.font,
                                                width: self.frame.width - 32)
        NSLayoutConstraint.activate([
            lblUsername.topAnchor.constraint(equalTo: imgProfile.bottomAnchor, constant: AppConstraints.padding16),
            lblUsername.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblUsername.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblUsername.heightAnchor.constraint(equalToConstant: heightUser),
            
            lblEmail.topAnchor.constraint(equalTo: lblUsername.bottomAnchor, constant: AppConstraints.padding16),
            lblEmail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblEmail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblEmail.heightAnchor.constraint(equalToConstant: heightUser),
            
            lblCardNumber.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: AppConstraints.padding16),
            lblCardNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblCardNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
        ])
    }
    
    internal func initBottomNavbarConstraints() {
        self.appNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.appNavBar.delegate = self
        NSLayoutConstraint.activate([
            appNavBar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: AppConstraints.paddingZero),
            appNavBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            appNavBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            appNavBar.heightAnchor.constraint(equalToConstant: AppConstraints.heightButton)
        ])
    }
}


// MARK: - View Methods
extension LoginView {
    
}

// MARK: - Nab bar Methods
extension ProfileView: AppNavBarDelegate {
    func chooseItem(_ index: Int) {
        self.delegate?.nextTab(index)
    }
}

