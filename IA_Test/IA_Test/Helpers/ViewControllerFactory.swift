//
//  ViewControllerFactory.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import UIKit

// MARK: - StoryBoard
class ViewControllerFactory {
    let storyboard: UIStoryboard?

    init(storyboard: UIStoryboard) {
        self.storyboard = storyboard
    }
    init() {
        self.storyboard = nil
    }
}


protocol ViewControllerFactoryContract {
    func createLoginView() -> LoginViewController
    func createProfileView(_ userInfo: UserInfoResponse) -> ProfileViewController
    func createMoviesView(_ movies: MoviesResponse) -> MoviesViewController
    func createDetailView(_ movieInfo: MovieData, _ mp4Path: String) -> DetailViewController
}


extension ViewControllerFactory: ViewControllerFactoryContract {
    func createLoginView() -> LoginViewController {
        return LoginViewController()
    }
    func createProfileView(_ userInfo: UserInfoResponse) -> ProfileViewController {
        return ProfileViewController(userInfo: userInfo)
    }
    func createMoviesView(_ movies: MoviesResponse) -> MoviesViewController {
        return MoviesViewController(movies: movies)
    }
    func createDetailView(_ movieInfo: MovieData, _ mp4Path: String) -> DetailViewController {
        return DetailViewController(movieInfo: movieInfo, mp4Path: mp4Path)
    }
}
