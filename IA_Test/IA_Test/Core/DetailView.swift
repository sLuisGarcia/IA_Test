//
//  DetailView.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit
import AVFoundation
import AVKit

// MARK: - View Delegate
protocol DetailViewDelegate: AnyObject {
    func returnView()
    func share()
}

class DetailView: UIView {
    
    // MARK: - Variable declaration
    private weak var delegate: DetailViewDelegate?
    private let movieInfo: MovieData
    
    // MARK: - View declaration
    private let navBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColors.baseBlue
        return view
    }()
    private let btnBack: UIImageView = {
        let btn = UIImageView(frame: .zero)
        btn.image = UIImage(named: "arrow")
        btn.backgroundColor = .clear
        btn.tintColor = AppColors.white
        btn.contentMode = .scaleAspectFit
        btn.isUserInteractionEnabled = true
        return btn
    }()
    private let lblProfile: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 20)
        lbl.textColor = AppColors.white
        lbl.textAlignment = .center
        return lbl
    }()
    private let btnShare: UIImageView = {
        let btn = UIImageView(frame: .zero)
        btn.image = UIImage(named: "share")
        btn.backgroundColor = .clear
        btn.tintColor = AppColors.white
        btn.contentMode = .scaleAspectFit
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    let playerContainerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()
    
    private let lblName: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.bold, 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblRank: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.regular, 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblGenre: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.regular, 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblLenght: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.regular, 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    private let lblSynopsis: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = AppUtils.font(.regular, 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Override Methods
    init(frame: CGRect, delegate: DetailViewDelegate, movieInfo: MovieData) {
        self.delegate = delegate
        self.movieInfo = movieInfo
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
        addSubview(navBar)
        addSubview(btnBack)
        addSubview(lblProfile)
        addSubview(btnShare)
        addSubview(playerContainerView)
        addSubview(lblName)
        addSubview(lblRank)
        addSubview(lblGenre)
        addSubview(lblLenght)
        addSubview(lblSynopsis)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        self.lblProfile.text = "Detalle"
        self.lblName.text = self.movieInfo.name
        
        var bodyString = "Clasificación: \(self.movieInfo.rating)"
        var range = (bodyString as NSString).range(of: "Clasificación:")
        var attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 12),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblRank.attributedText = attrStr
        
        bodyString = "Género: \(self.movieInfo.genre)"
        range = (bodyString as NSString).range(of: "Género:")
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 12),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblGenre.attributedText = attrStr
        
        bodyString = "Duración: \(self.movieInfo.length)"
        range = (bodyString as NSString).range(of: "Duración:")
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 12),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblLenght.attributedText = attrStr
        
        bodyString = "Sinopsis: \(self.movieInfo.synopsis)"
        range = (bodyString as NSString).range(of: "Sinopsis:")
        attrStr = NSMutableAttributedString(string: bodyString, attributes: [
            NSAttributedString.Key.font: AppUtils.font(.bold, 12),
            NSAttributedString.Key.foregroundColor: AppColors.baseBlue
        ])
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.darkGray, range: range)
        self.lblSynopsis.attributedText = attrStr
    }
    
    // MARK: - Add Constraints
    internal func initConstraints() {
        initHeaderConstraints()
        initDataConstraints()
    }
    
    // MARK: - Add Listeners
    internal func initListeners() {
        self.btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnView)))
        self.btnShare.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(share)))
    }
    
    // MARK: - Configure Views
    internal func initHeaderConstraints() {
        self.navBar.translatesAutoresizingMaskIntoConstraints = false
        self.lblProfile.translatesAutoresizingMaskIntoConstraints = false
        self.btnBack.translatesAutoresizingMaskIntoConstraints = false
        self.btnShare.translatesAutoresizingMaskIntoConstraints = false
        self.playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: AppConstraints.paddingZero),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            navBar.heightAnchor.constraint(equalToConstant: AppConstraints.heightButton),
            
            btnBack.topAnchor.constraint(equalTo: navBar.topAnchor, constant: AppConstraints.padding12),
            btnBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding12),
            btnBack.widthAnchor.constraint(equalToConstant: AppConstraints.padding24),
            
            lblProfile.topAnchor.constraint(equalTo: navBar.centerYAnchor),
            lblProfile.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblProfile.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            btnShare.topAnchor.constraint(equalTo: navBar.topAnchor, constant: AppConstraints.padding12),
            btnShare.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding12),
            btnShare.widthAnchor.constraint(equalToConstant: AppConstraints.padding24),
            
            playerContainerView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: AppConstraints.padding16),
            playerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            playerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            playerContainerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    internal func initDataConstraints() {
        self.lblName.translatesAutoresizingMaskIntoConstraints = false
        self.lblRank.translatesAutoresizingMaskIntoConstraints = false
        self.lblGenre.translatesAutoresizingMaskIntoConstraints = false
        self.lblLenght.translatesAutoresizingMaskIntoConstraints = false
        self.lblSynopsis.translatesAutoresizingMaskIntoConstraints = false
        let heightName = AppUtils.heightForView(text: lblName.text ?? "",
                                                font: lblName.font,
                                                width: self.frame.width - 32)
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: playerContainerView.bottomAnchor, constant: AppConstraints.padding16),
            lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblName.heightAnchor.constraint(equalToConstant: heightName),
            
            lblRank.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: AppConstraints.padding12),
            lblRank.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblRank.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblRank.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblGenre.topAnchor.constraint(equalTo: lblRank.bottomAnchor, constant: AppConstraints.padding12),
            lblGenre.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblGenre.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblGenre.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblLenght.topAnchor.constraint(equalTo: lblGenre.bottomAnchor, constant: AppConstraints.padding12),
            lblLenght.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblLenght.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16),
            lblLenght.heightAnchor.constraint(equalToConstant: AppConstraints.padding20),
            
            lblSynopsis.topAnchor.constraint(equalTo: lblLenght.bottomAnchor, constant: AppConstraints.padding12),
            lblSynopsis.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.padding16),
            lblSynopsis.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstraints.padding16)
        ])
    }
}


// MARK: - View Methods
extension DetailView {
    @objc func returnView() {
        self.delegate?.returnView()
    }
    
    @objc func share() {
        self.delegate?.share()
    }
}


