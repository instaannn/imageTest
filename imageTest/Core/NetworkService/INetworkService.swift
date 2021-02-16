//
//  INetworkService.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import Moya

//MARK: - INetworkService

protocol INetworkService {
    var provider: MoyaProvider<ImageService> { get }
    func fetchPhotos(page: Int, completion: @escaping (Pagination, [ImagesModel]) -> Void)
    func fetchDetailPhoto(id: String, completion: @escaping (ImageDetailModel) -> Void)
}
