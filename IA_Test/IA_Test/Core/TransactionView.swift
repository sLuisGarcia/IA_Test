//
//  TransactionView.swift
//  IA_Test
//
//  Created by Luis García on 26/01/22.
//

import UIKit

class TransactionView: UIView {
    
    // MARK: - Variable declaration
    private let transactions: TransactionsResponse
    
    // MARK: - View declaration
    private let lblName: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 20)
        lbl.textColor = AppColors.darkBlue
        lbl.textAlignment = .center
        return lbl
    }()

    private let lblBalance: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let lblVisitas: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let lblLevel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let lblNextLevel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.regular, 12)
        lbl.textColor = AppColors.darkGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Override Methods
    init(frame: CGRect, transactions: TransactionsResponse) {
        self.transactions = transactions
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
        addSubview(lblName)
        addSubview(lblBalance)
        addSubview(lblVisitas)
        addSubview(lblLevel)
        addSubview(lblNextLevel)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        let points = self.transactions.balance_list.filter({$0.key == "points"}).first
        let visits = self.transactions.balance_list.filter({$0.key == "visits"}).first
        let level = self.transactions.level
        
        self.lblName.text = self.transactions.name
        var bodyString = "\(points?.balance ?? 0.0) puntos \(points?.name ?? "")"
        var range = (bodyString as NSString).range(of: "\(points?.balance ?? 0.0)")
        var attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.regular, 12),
            NSAttributedString.Key.foregroundColor: AppColors.darkGray
        ])
        attrStr.addAttribute(NSAttributedString.Key.font, value: AppUtils.font(.bold, 20), range: range)
        self.lblBalance.attributedText = attrStr

        let visitStr = "\(Int(visits?.balance ?? 0.0))"
        bodyString = "\(visitStr) \(visits?.message ?? "") \(visits?.name ?? "")"
        range = (bodyString as NSString).range(of: visitStr)
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.regular, 12),
            NSAttributedString.Key.foregroundColor: AppColors.darkGray
        ])
        attrStr.addAttribute(NSAttributedString.Key.font, value: AppUtils.font(.bold, 20), range: range)
        self.lblVisitas.attributedText = attrStr

        bodyString = "Nivel: \(level.name)"
        range = (bodyString as NSString).range(of: level.name)
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.regular, 12),
            NSAttributedString.Key.foregroundColor: AppColors.darkGray
        ])
        attrStr.addAttribute(NSAttributedString.Key.font, value: AppUtils.font(.bold, 20), range: range)
        self.lblLevel.attributedText = attrStr
        self.lblNextLevel.text = level.message
    }
    
    // MARK: - Add Constraints
    internal func initConstraints() {
        self.lblName.translatesAutoresizingMaskIntoConstraints = false
        self.lblBalance.translatesAutoresizingMaskIntoConstraints = false
        self.lblVisitas.translatesAutoresizingMaskIntoConstraints = false
        self.lblLevel.translatesAutoresizingMaskIntoConstraints = false
        self.lblNextLevel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: AppConstraints.padding32),
            lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblName.heightAnchor.constraint(equalToConstant: AppConstraints.padding32),
            
            lblBalance.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: AppConstraints.padding24),
            lblBalance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblBalance.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblBalance.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblVisitas.topAnchor.constraint(equalTo: lblBalance.bottomAnchor, constant: AppConstraints.padding16),
            lblVisitas.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblVisitas.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblVisitas.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblLevel.topAnchor.constraint(equalTo: lblVisitas.bottomAnchor, constant: AppConstraints.padding16),
            lblLevel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblLevel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblLevel.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblNextLevel.topAnchor.constraint(equalTo: lblLevel.bottomAnchor, constant: AppConstraints.padding8),
            lblNextLevel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblNextLevel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
        ])
    }
}
