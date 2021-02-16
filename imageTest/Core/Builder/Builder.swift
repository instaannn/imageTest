//
//  Builder.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

import Foundation

// MARK: Builder

final class Builder: IBuilder {
    
    // MARK: - Public methods
    
    static func makeImagesViewController(page: Int) -> ImagesViewController {
        
        let networkService = NetworkService()
        let viewController = ImagesViewController()
        let viewModel = ImagesViewModel(networkService: networkService, page: page)
        
        viewController.viewModel = viewModel
        viewController.networkService = networkService
        
        return viewController
    }
    
    static func makeImageDetailViewController(id: String) -> ImageDetailViewController {
       
        let networkService = NetworkService()
        let viewController = ImageDetailViewController()
        let viewModel = ImageDetailViewModel(networkService: networkService, id: id)
        
        viewController.viewModel = viewModel
        
        return viewController
    }

}
