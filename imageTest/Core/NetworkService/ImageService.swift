//
//  ImageService.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import Foundation
import Moya

enum ImageService {
    case photos(page: Int)
    case detailPhoto(id: String)
}

extension ImageService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Url.urlPhotos) else { fatalError("baseURL could not be configurate")}
        return url
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos/"
        case .detailPhoto(let id):
            return "/photos/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .photos(let page):
            return .requestParameters(parameters: ["page": page, "client_id" : Url.accessKey],
                                      encoding: URLEncoding.queryString)
        case .detailPhoto(_):
            return .requestParameters(parameters: ["client_id" : Url.accessKey],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
