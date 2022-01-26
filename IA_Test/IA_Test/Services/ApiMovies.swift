//
//  ApiMovies.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Alamofire
import RxSwift

protocol ApiMovies {
    func getLogin(_ username: String, _ password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (Error) -> Void)
    func getUserInfo(success: @escaping (UserInfoResponse) -> Void, failure: @escaping (Error) -> Void)
    func getMovies(success: @escaping (MoviesResponse) -> Void, failure: @escaping (Error) -> Void)
    func getTransactions(success: @escaping (TransactionsResponse) -> Void, failure: @escaping (Error) -> Void)
}


class ApiMoviesImpl: ApiMovies {
    var networkService: NetworkService = NetworkServiceImpl(configuration: ServiceConfig.appConfig(), encodeUtils: EncodeUtils())
    let disposeBag = DisposeBag()
    let appManager: AppManager = AppManager()
    
    func getLogin(_ username: String, _ password: String, success: @escaping (LoginResponse) -> Void, failure: @escaping (Error) -> Void) {
        let request = Request(method: .post,
                              path: "v2/oauth/token",
                              parameters: HeaderFactory.getLoginParams(username, password),
                              encoding: URLEncoding(destination: .methodDependent),
                              headers: HeaderFactory.getLoginHeaders())
        networkService.execute(request).subscribe(onNext: { (response: LoginResponse) in
            success(response)
        }, onError: { (error: Error) in
            failure(error)
        }).disposed(by: disposeBag)
    }
    
    func getUserInfo(success: @escaping (UserInfoResponse) -> Void, failure: @escaping (Error) -> Void) {
        let access_token = appManager.getStringData(sessionName: AppManager.accessToken)
        let request = Request(method: .get,
                              path: "v1/members/profile?country_code=MX",
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: HeaderFactory.getAuthHeaders(access_token))
        networkService.execute(request).subscribe(onNext: { (response: UserInfoResponse) in
            success(response)
        }, onError: { (error: Error) in
            failure(error)
        }).disposed(by: disposeBag)
    }
    
    func getMovies(success: @escaping (MoviesResponse) -> Void, failure: @escaping (Error) -> Void) {
        let request = Request(method: .get,
                              path: "v2/movies?country_code=MX&cinemas=61",
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: HeaderFactory.getBaseHeaders())
        networkService.execute(request).subscribe(onNext: { (response: MoviesResponse) in
            success(response)
        }, onError: { (error: Error) in
            failure(error)
        }).disposed(by: disposeBag)
    }
    
    func getTransactions(success: @escaping (TransactionsResponse) -> Void, failure: @escaping (Error) -> Void) {
        let transactionReq = TransactionsRequest("1303030763820961", "4804", "MX", true)
        let params = transactionReq.dictionary ?? [:]
        let request = Request(method: .post,
                              path: "v2/members/loyalty",
                              parameters: params,
                              encoding: JSONEncoding.default,
                              headers: HeaderFactory.getBaseHeaders())
        networkService.execute(request).subscribe(onNext: { (response: TransactionsResponse) in
            success(response)
        }, onError: { (error: Error) in
            failure(error)
        }).disposed(by: disposeBag)
    }
}
