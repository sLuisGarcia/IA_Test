//
//  NetworkService.swift
//  IA_Test
//
//  Created by Luis García on 21/01/22.
//

import Alamofire
import RxSwift
import UIKit

protocol NetworkService {
    init(configuration: ServiceConfig, encodeUtils: EncodeUtils)
    func execute<T: Initable>(_ request: Request) -> Observable<T>
}


public class NetworkServiceImpl: NetworkService {
    private static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        let urlPolicy = Enviroment.rootURL.absoluteString.replacingOccurrences(of: "https://", with: "").components(separatedBy: "/")
        let serverTrustPolicy: [String: ServerTrustPolicy] = [
            urlPolicy[0]: .pinCertificates(
                certificates: [],
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    lazy var appDelegate: AppDelegate = {
        if Thread.isMainThread {
            return (UIApplication.shared.delegate as? AppDelegate)!
        } else {
            let appDelegate = DispatchQueue.main.sync {
                return (UIApplication.shared.delegate as? AppDelegate)!
            }
            return appDelegate
        }
    }()
    private let configuration: ServiceConfig
    private let encodeUtils: EncodeUtils
//    private let appManager = AppManager()
    
    required init(configuration: ServiceConfig, encodeUtils: EncodeUtils = EncodeUtils()) {
        self.configuration = configuration
        self.encodeUtils = encodeUtils
    }
    
    func execute<T: Initable>(_ request: Request) -> Observable<T> {
        let url = configuration.url.absoluteString + "/" + request.path
        return Observable<T>.create { [weak self] observer in
            let request = NetworkServiceImpl.manager.request(url,
                                            method: request.method,
                                            parameters: request.parameters,
                                            encoding: request.encoding,
                                            headers: request.headers)
                .responseString { (response: DataResponse<String>) in
                    switch response.result {
                    case let .success(value):
                        do {
                            if let decodedResponse = try self?.encodeUtils.get(T.self, from: value) {
                                if response.response?.statusCode == 500 {
                                    observer.onError(EncodeUtilsErrors.cantDecodeData)
                                } else {
                                    observer.onNext(decodedResponse)
                                    observer.onCompleted()
                                }
                            } else {
                                observer.onError(EncodeUtilsErrors.cantDecodeData)
                            }
                        } catch {
                            observer.onError(EncodeUtilsErrors.cantDecodeData)
                        }
                    case let .failure(error):
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
