//
//  ProfileViewController.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Variable declaration
    lazy var mainView: ProfileView? = {
        return ProfileView(frame: UIScreen.main.bounds, delegate: self, userInfo: self.userInfo)
    }()
    private let userInfo: UserInfoResponse
    private let apiMovies: ApiMovies = ApiMoviesImpl()
    private let appManager = AppManager()
    private var appLoader: AppLoader?
    
    // MARK: - Override Methods
    init(userInfo: UserInfoResponse) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.view = mainView
        self.appLoader = AppLoader(parentView: self)
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
extension ProfileViewController: ProfileViewDelegate {
    func nextTab(_ index: Int) {
        if index != 0 {
            self.appLoader?.isLoading()
            NavBarHelper().getViewController(index, self) { view in
                self.appLoader?.dismiss()
                self.navigationController?.pushViewController(view, animated: true)
            } failure: { error in
                self.appLoader?.dismiss()
                self.appManager.showAlert(self, "ALERTA", "Ocurrió un error al realizar la petición. Intenta de nuevo", "Entendido")
            }
        }
    }
}
