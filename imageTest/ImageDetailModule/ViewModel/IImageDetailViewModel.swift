//
//  IImageDetailViewModel.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

// MARK: - IImageDetailViewModel

protocol IImageDetailViewModel: AnyObject {
    var imageDetailDidChange: ((ImageDetailModel) -> ())? { get set }
    func didWillappear()
}
