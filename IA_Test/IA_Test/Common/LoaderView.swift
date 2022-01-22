//
//  LoaderView.swift
//  IA_Test
//
//  Created by Luis García on 22/01/22.
//

import UIKit
import Lottie

class LoaderView: UIView {
    
    // MARK: - Declare Animation View
    private let backgroundView: UIView = {
        let backView = UIView(frame: .zero)
        backView.backgroundColor = .white
        return backView
    }()
    
    private let animationView: AnimationView = {
        let anim = AnimationView(frame: .zero)
        anim.animation = Animation.named("loader")
        anim.backgroundColor = .white
        anim.loopMode = .loop
        anim.play()
        return anim
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
        initConstraintsBackgroundView()
        initConstraintsAnimation()
    }
    
    // MARK: - Add subviews
    internal func initViews() {
        addSubview(backgroundView)
        addSubview(animationView)
    }
    
    // MARK: - Add Constraints
    internal func initConstraintsAnimation() {
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: AppConstraints.paddingZero),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: AppConstraints.paddingZero),
            animationView.widthAnchor.constraint(equalToConstant: 150),
            animationView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    internal func initConstraintsBackgroundView() {
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: AppConstraints.paddingZero),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: AppConstraints.paddingZero)
        ])
    }
    
    func reset() {
        self.animationView.play()
    }
}

