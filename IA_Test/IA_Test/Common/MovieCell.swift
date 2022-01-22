//
//  MovieCell.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Variable declaration
    weak var imageCard: UIImageView!
    weak var lblTitle: UILabel!
    
    // MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imgCard = UIImageView(frame: .zero)
        let lblTitle = UILabel(frame: .zero)
        imgCard.contentMode = .scaleAspectFit
        lblTitle.font = AppUtils.font(.regular, 10)
        lblTitle.textAlignment = .center
        lblTitle.textColor = AppColors.darkBlue
        self.contentView.addSubview(imgCard)
        self.contentView.addSubview(lblTitle)
        imgCard.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.numberOfLines = 0
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imgCard.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: AppConstraints.padding8),
            imgCard.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: AppConstraints.padding16),
            imgCard.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -AppConstraints.padding16),
            imgCard.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: -AppConstraints.padding8),
            
            lblTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: AppConstraints.paddingZero),
            lblTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: AppConstraints.paddingZero),
            lblTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: AppConstraints.paddingZero),
            lblTitle.heightAnchor.constraint(equalToConstant: AppConstraints.padding32)
        ])
        
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowColor = AppColors.baseGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        
        self.imageCard = imgCard
        self.lblTitle = lblTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setContent(_ imgStr: String, _ title: String) {
        self.imageCard.loadFrom(URLAddress: imgStr)
        self.lblTitle.text = title
    }
}
