//
//  AppLoader.swift
//  IA_Test
//
//  Created by Luis García on 22/01/22.
//

import UIKit

class AppLoader {
    
    // MARK: - Variable declaration
    private var parentView: UIViewController
    private var loaderView: LoaderView = {
        return LoaderView(frame: UIScreen.main.bounds)
    }()
    private var navController: Int = 0
    
    // MARK: - Initializer
    init(parentView: UIViewController) {
        self.parentView = parentView
    }
    
    // MARK: - View Methods
    func isLoading() {
        parentView.dismissKeyboard()
        self.loaderView.reset()
        if !(self.parentView.navigationController?.isNavigationBarHidden ?? false) {
            self.navController = 1
            self.parentView.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        self.parentView.view.addSubview(self.loaderView)
    }
    
    func dismiss() {
        if self.navController == 1 {
            self.parentView.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        self.loaderView.removeFromSuperview()
    }

    
}
