//
//  MoviesViewController.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class MoviesViewController: UIViewController {

    // MARK: - Variable declaration
    lazy var mainView: MoviesView? = {
        return MoviesView(frame: UIScreen.main.bounds, delegate: self, movies: self.movies)
    }()
    private let movies: MoviesResponse
    private let viewControllerFactory = ViewControllerFactory()
    
    // MARK: - Override Methods
    init(movies: MoviesResponse) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Initializers
    private func initUI() {
        self.view.backgroundColor = .white
        self.topColouredView(color: AppColors.baseBlue)
    }
}

// MARK: - View Methods
extension MoviesViewController: MoviesViewDelegate {
    func nextTab(_ index: Int) {
        if index != 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showDetail(_ movie: MovieData) {
        let path = self.movies.routes.filter({$0.code == "trailer_mp4"}).first?.sizes.medium ?? ""
        let name = movie.media.filter({$0.code == "trailer_mp4"}).first?.resource ?? ""
        let view = self.viewControllerFactory.createDetailView(movie, path + name)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
