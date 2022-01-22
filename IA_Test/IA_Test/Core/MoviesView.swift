//
//  MoviesView.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

// MARK: - View Delegate
protocol MoviesViewDelegate: AnyObject {
    func nextTab(_ index: Int)
    func showDetail(_ movie:MovieData)
}

class MoviesView: UIView {
    
    // MARK: - Variable declaration
    private weak var delegate: MoviesViewDelegate?
    private let movies: MoviesResponse
    private weak var collectionView: UICollectionView!
    
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
    
    private let appNavBar: AppNavBar = {
        let navbar = AppNavBar(frame: .zero)
        return navbar
    }()
    
    // MARK: - Override Methods
    init(frame: CGRect, delegate: MoviesViewDelegate, movies: MoviesResponse) {
        self.delegate = delegate
        self.movies = movies
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
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        let colView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView = colView
        addSubview(collectionView)
        addSubview(appNavBar)
    }
    
    // MARK: - Add Strings
    internal func initStrings() {
        self.lblProfile.text = "Perfil"
        self.appNavBar.configureBar(1)
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
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: AppConstraints.paddingZero),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            navBar.heightAnchor.constraint(equalToConstant: AppConstraints.heightButton),
            
            lblProfile.topAnchor.constraint(equalTo: navBar.centerYAnchor),
            lblProfile.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblProfile.heightAnchor.constraint(equalToConstant: AppConstraints.padding20)
        ])
    }
    
    internal func initDataConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: AppConstraints.paddingZero),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstraints.paddingZero),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AppConstraints.paddingZero),
            collectionView.bottomAnchor.constraint(equalTo: appNavBar.topAnchor, constant: AppConstraints.paddingZero)
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


// MARK: - View Collection Methods
extension MoviesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        
        var imgPath: String
        if self.movies.routes[0].sizes.small != nil {
            imgPath = self.movies.routes[0].sizes.small ?? ""
        } else {
            imgPath = self.movies.routes[0].sizes.medium ?? ""
        }
        let imgStr = self.movies.movies[indexPath.row].media.filter({$0.code == "poster"}).first?.resource ?? ""
        let imgUrl = imgPath + imgStr
        cell.setContent(imgUrl, self.movies.movies[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.showDetail(self.movies.movies[indexPath.row])
    }
}

// MARK: - Nab bar Methods
extension MoviesView: AppNavBarDelegate {
    func chooseItem(_ index: Int) {
        self.delegate?.nextTab(index)
    }
}

