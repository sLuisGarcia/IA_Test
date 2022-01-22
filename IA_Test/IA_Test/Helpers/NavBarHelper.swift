//
//  NavBarHelper.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

class NavBarHelper {
    private let apiMovies: ApiMovies = ApiMoviesImpl()
    private let viewControllerFactory = ViewControllerFactory()
    
    func getViewController(_ index: Int, _ context: UIViewController, success: @escaping (UIViewController) -> Void, failure: @escaping (Error) -> Void) {
        if index == 0 {
            if let view = context.navigationController?.viewControllers.filter({ $0 is ProfileViewController}).first {
               success(view)
            }
            success(UIViewController())
        } else {
            self.apiMovies.getMovies { response in
                success(self.viewControllerFactory.createMoviesView(response))
            } failure: { error in
                failure(error)
            }
        }
    }
}
