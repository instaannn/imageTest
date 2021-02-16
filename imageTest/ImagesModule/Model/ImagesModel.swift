//
//  ImagesModel.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

// MARK: - ImagesModel

struct ImagesModel: Decodable {
    let id: String
    let description: String?
    let urls: Urls
}

// MARK: - Urls

struct Urls: Decodable {
    let small: String
}
