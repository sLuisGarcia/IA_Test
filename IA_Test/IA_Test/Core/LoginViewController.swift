//
//  LoginViewController.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Variable declaration
    lazy var mainView: LoginView? = {
        return LoginView(frame: UIScreen.main.bounds, delegate: self)
    }()
    private let apiMovies: ApiMovies = ApiMoviesImpl()
    private let appManager = AppManager()
    private let viewControllerFactory = ViewControllerFactory()
    private var appLoader: AppLoader?
    
    // MARK: - Override Methods
    init() {
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
    }
}

// MARK: - View Methods
extension LoginViewController: LoginViewDelegate {
    func validateLogin(_ username: String, _ password: String) {
        self.appLoader?.isLoading()
        if !username.isEmpty, !password.isEmpty {
            self.apiMovies.getLogin(username, password) { response in
                self.getUserData(response.access_token)
            } failure: { error in
                self.appLoader?.dismiss()
                self.appManager.showAlert(self, "ALERTA", "Usuario y/o contraseña incorrecta", "Intentar de nuevo")
            }
        } else {
            self.appLoader?.dismiss()
            self.appManager.showAlert(self, "ALERTA", "Completa ambos campos para continuar", "Entendido")
        }
    }
    
    private func getUserData(_ accessToken: String) {
        self.appManager.setStringData(sessionName: AppManager.accessToken, sessionValue: accessToken)
        self.apiMovies.getUserInfo { response in
            self.appLoader?.dismiss()
            let view = self.viewControllerFactory.createProfileView(response)
            self.navigationController?.pushViewController(view, animated: true)
        } failure: { error in
            self.appLoader?.dismiss()
            self.appManager.showAlert(self, "ALERTA", "Ocurrió un error al realizar la petición. Intenta de nuevo", "Entendido")
        }
    }
}
