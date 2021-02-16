//
//  IImagesViewModel.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

// MARK: - IImagesViewModel

protocol IImagesViewModel: AnyObject {
    var imagesDidChange: (([ImagesModel], Pagination) -> ())? { get set }
    func didWillappear(page: Int)
}
