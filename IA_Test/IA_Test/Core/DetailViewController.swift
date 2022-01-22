//
//  DetailViewController.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    // MARK: - Variable declaration
    lazy var mainView: DetailView? = {
        return DetailView(frame: UIScreen.main.bounds, delegate: self, movieInfo: self.movieInfo)
    }()
    private let movieInfo: MovieData
    private let mp4Path: String
    
    // MARK: - Override Methods
    init(movieInfo: MovieData, mp4Path: String) {
        self.movieInfo = movieInfo
        self.mp4Path = mp4Path
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
        
        let videoUrl = URL(string: self.mp4Path)
        let player = AVPlayer(url: videoUrl!)
    
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.addChild(playerVC)
        playerVC.view.frame = (self.mainView?.playerContainerView.bounds)!
        self.mainView?.playerContainerView.addSubview(playerVC.view)
        playerVC.didMove(toParent: self)
    }
}

// MARK: - View Methods
extension DetailViewController: DetailViewDelegate {
    func returnView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func share() {
        //
    }
}

