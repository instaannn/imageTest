//
//  ImageDetailModel.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

// MARK: - ImageDetailModel

struct ImageDetailModel: Decodable {
    let description: String?
    let urls: UrlImage
}

// MARK: - UrlImage

struct UrlImage: Decodable {
    let full: String
}
