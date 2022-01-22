//
//  AppNavBar.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

protocol AppNavBarDelegate: AnyObject {
    func chooseItem(_ index: Int)
}

class AppNavBar: UIView {
    
    // MARK: - Variable declaration
    weak var delegate: AppNavBarDelegate?
    
    // MARK: - View declaration
    private let topNavbar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColors.darkBlue
        return view
    }()
    private let bottomNavbar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private let img1: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "user")
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
    private let img2: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "movies")
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        return img
    }()
    private let stackImg: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let lbl1: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 12)
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    private let lbl2: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 12)
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    private let item1: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColors.baseBlue
        return view
    }()
    private let item2: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    private let stackItem: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    // MARK: - Override Methods
    override init(frame: CGRect) {
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
        initListeners()
    }
    
    // MARK: - Add subviews
    internal func initViews() {
        addSubview(topNavbar)
        addSubview(bottomNavbar)
        stackItem.addArrangedSubview(item1)
        stackItem.addArrangedSubview(item2)
        addSubview(stackItem)
        stackImg.addArrangedSubview(img1)
        stackImg.addArrangedSubview(img2)
        addSubview(stackImg)
        addSubview(lbl1)
        addSubview(lbl2)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        self.lbl1.text = "Perfil"
        self.lbl2.text = "Cartelera"
    }
    
    // MARK: - Add Constraints
    internal func initConstraints() {
        self.topNavbar.translatesAutoresizingMaskIntoConstraints = false
        self.bottomNavbar.translatesAutoresizingMaskIntoConstraints = false
        self.stackImg.translatesAutoresizingMaskIntoConstraints = false
        self.stackItem.translatesAutoresizingMaskIntoConstraints = false
        self.lbl1.translatesAutoresizingMaskIntoConstraints = false
        self.lbl2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topNavbar.bottomAnchor.constraint(equalTo: bottomNavbar.topAnchor, constant: AppConstraints.paddingZero),
            topNavbar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            topNavbar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            topNavbar.heightAnchor.constraint(equalToConstant: 1),
            
            bottomNavbar.topAnchor.constraint(equalTo: topAnchor, constant: AppConstraints.paddingZero),
            bottomNavbar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            bottomNavbar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            bottomNavbar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: AppConstraints.paddingZero),
            
            stackImg.topAnchor.constraint(equalTo: bottomNavbar.topAnchor, constant: AppConstraints.padding8),
            stackImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            stackImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            stackImg.heightAnchor.constraint(equalToConstant: AppConstraints.padding24),
            
            lbl1.topAnchor.constraint(equalTo: stackImg.bottomAnchor, constant: AppConstraints.paddingZero),
            lbl1.centerXAnchor.constraint(equalTo: img1.centerXAnchor),
            lbl2.topAnchor.constraint(equalTo: stackImg.bottomAnchor, constant: AppConstraints.paddingZero),
            lbl2.centerXAnchor.constraint(equalTo: img2.centerXAnchor),
            
            stackItem.topAnchor.constraint(equalTo: bottomNavbar.topAnchor, constant: AppConstraints.paddingZero),
            stackItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            stackItem.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            stackItem.bottomAnchor.constraint(equalTo: bottomNavbar.bottomAnchor, constant: -AppConstraints.paddingZero)
        ])
    }
    
    // MARK: - Add Listeners
    internal func initListeners() {
        self.item1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfile)))
        self.img1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfile)))
        self.lbl1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfile)))
        self.item2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCartelera)))
        self.img2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCartelera)))
        self.lbl2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectCartelera)))
    }
}

// MARK: - View Method
extension AppNavBar {
    @objc func selectProfile() {
        self.delegate?.chooseItem(0)
    }
    
    @objc func selectCartelera() {
        self.delegate?.chooseItem(1)
    }

    func configureBar(_ index: Int) {
        self.item1.backgroundColor = .clear
        self.img1.tintColor = AppColors.baseGray
        self.lbl1.textColor = AppColors.baseGray
        self.item2.backgroundColor = .clear
        self.img2.tintColor = AppColors.baseGray
        self.lbl2.textColor = AppColors.baseGray
        if index == 0 {
            self.item1.backgroundColor = AppColors.baseBlue
            self.img1.tintColor = AppColors.white
            self.lbl1.textColor = AppColors.white
        } else{
            self.item2.backgroundColor = AppColors.baseBlue
            self.img2.tintColor = AppColors.white
            self.lbl2.textColor = AppColors.white
        }
    }
}
