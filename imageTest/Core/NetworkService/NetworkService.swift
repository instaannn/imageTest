//
//  NetworkService.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import Foundation
import Moya

// MARK: - NetworkService

final class NetworkService: INetworkService {
 
    var provider = MoyaProvider<ImageService>()
    
    // MARK: - Public methods
    
    func fetchPhotos(page: Int, completion: @escaping (Pagination, [ImagesModel]) -> Void) {
        downloadJsonPagination(target: .photos(page: page), completion: completion)
    }
    
    func fetchDetailPhoto(id: String, completion: @escaping (ImageDetailModel) -> Void) {
        downloadJson(target: .detailPhoto(id: id), completion: completion)
    }
    
    // MARK: - Private methods
    
    private func downloadJsonPagination<T: Decodable>(target: ImageService,
                                                      completion: @escaping(Pagination, T) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self,
                                                           from: response.data)
                    let total = Int(response.response?.allHeaderFields["x-total"] as? String ?? "0") ?? 0
                    let perPage = Int(response.response?.allHeaderFields["x-per-page"] as? String ?? "0") ?? 0
                    let totalPage = total / perPage
                    let pagination = Pagination(xTotal: total, xPerPage: perPage, totalPage: totalPage)
                    completion(pagination, results)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func downloadJson<T: Decodable>(target: ImageService, completion: @escaping(T) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self,
                                                           from: response.data)
                    completion(results)
                } catch let error {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
