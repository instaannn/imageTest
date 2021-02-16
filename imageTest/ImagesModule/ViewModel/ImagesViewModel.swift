//
//  ImagesViewModel.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import Foundation

// MARK: - ProductsViewModel

final class ImagesViewModel: IImagesViewModel {
    
    // MARK: - Public properties
    
    var imagesDidChange: (([ImagesModel], Pagination) -> ())?
    var page: Int?
    
    // MARK: - Private properties
    
    private var networkService: INetworkService
    
    // MARK: - Init
    
    init(networkService: INetworkService, page: Int) {
        self.networkService = networkService
        self.page = page
    }
    
    // MARK: Public methods
    
    func didWillappear(page: Int) {
        fetchPhotos(page: page)
    }
    
    // MARK: - Private methods
    
    private func fetchPhotos(page: Int) {
        networkService.fetchPhotos(page: page, completion: { [weak self] viewModel, pagination in
            guard let self = self, let imagesDidChange = self.imagesDidChange else { return }
            imagesDidChange(pagination, viewModel)
        })
    }
    
}
