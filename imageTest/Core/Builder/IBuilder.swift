//
//  IBuilder.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

import Foundation

//MARK: - IBuilder

protocol IBuilder {
    static func makeImagesViewController(page: Int) -> ImagesViewController
    static func makeImageDetailViewController(id: String) -> ImageDetailViewController
}
