//
//  ButtonPrimary.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

// MARK: - View Delegate
protocol ButtonPrimaryDelegate: AnyObject {
    func didClickButton(index: Int)
}

class ButtonPrimary: UIView {
    
    // MARK: - Variable declaration
    weak var delegate: ButtonPrimaryDelegate?
    
    // MARK: - View declaration
    private let btnPrimary: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = AppUtils.font(.bold, 16)
        button.layer.cornerRadius = AppConstraints.heightButton / 2
        return button
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
        addSubview(btnPrimary)
        self.btnPrimary.translatesAutoresizingMaskIntoConstraints = false
        self.btnPrimary.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didClickBtn)))
        NSLayoutConstraint.activate([
            btnPrimary.topAnchor.constraint(equalTo: topAnchor, constant: AppConstraints.paddingZero),
            btnPrimary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            btnPrimary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            btnPrimary.bottomAnchor.constraint(equalTo: bottomAnchor, constant: AppConstraints.paddingZero)
        ])
    }
}

extension ButtonPrimary {
    func setText(_ text: String) {
        self.btnPrimary.setTitle(text, for: .normal)
    }
    
    func setRadius(_ set: Bool = true) {
        if !set {
            self.btnPrimary.layer.cornerRadius = 0
        }
    }
    
    func setButtonStyle(_ title: String, _ status: ButtonStatus) {
        btnPrimary.setTitle(title, for: .normal)
        btnPrimary.titleLabel?.lineBreakMode = .byWordWrapping
        if status == .active {
            btnPrimary.backgroundColor = AppColors.baseBlue
            btnPrimary.setTitleColor(AppColors.white, for: .normal)
            btnPrimary.isEnabled = true
        } else if status == .inactive {
            btnPrimary.backgroundColor = AppColors.baseGray
            btnPrimary.setTitleColor(AppColors.darkGray, for: .normal)
            btnPrimary.isEnabled = false
        } else {
            btnPrimary.backgroundColor = .clear
            btnPrimary.layer.borderWidth = 1.0
            btnPrimary.layer.borderColor = AppColors.darkBlue.cgColor
            btnPrimary.setTitleColor(AppColors.darkBlue, for: .normal)
            btnPrimary.isEnabled = true
        }
    }
    
    @objc func didClickBtn() {
        delegate?.didClickButton(index: tag)
    }
}
