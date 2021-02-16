//
//  ImageDetailViewModel.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

import Foundation

// MARK: - ProductsViewModel

final class ImageDetailViewModel: IImageDetailViewModel {
    
    // MARK: - Public properties
    
    var imageDetailDidChange: ((ImageDetailModel) -> ())?
    var id: String?
    
    // MARK: - Private properties
    
    private var networkService: INetworkService
    
    // MARK: - Init
    
    init(networkService: INetworkService, id: String) {
        self.networkService = networkService
        self.id = id
    }
    
    // MARK: - Public methods
    
    func didWillappear() {
        fetchDetailPhoto()
    }
    
    // MARK: - Private methods
    
    private func fetchDetailPhoto() {
        guard let id = id else { return }
        networkService.fetchDetailPhoto(id: id, completion: { [weak self] viewModel in
            guard let self = self, let imageDetailDidChange = self.imageDetailDidChange else { return }
            imageDetailDidChange(viewModel)
        })
    }
    
}
