//
//  ImagesViewController.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import UIKit
import Moya

// MARK: - ImagesViewController

final class ImagesViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Public properties
    
    public var viewModel: IImagesViewModel?
    public var networkService: INetworkService?
    
    // MARK: - Private properties
    
    private var tableView = UITableView()
    private let provider = MoyaProvider<ImageService>()
    private var imagesModel = [ImagesModel]()
    private var selectId: String?
    private var page = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVies()
        setupBinding(page: page)
    }
    
    private func setupBinding(page: Int) {
        viewModel?.didWillappear(page: page)
        viewModel?.imagesDidChange = { [weak self] (viewModel, pagination) in
            guard let self = self else { return }
            self.imagesModel.append(contentsOf: viewModel)
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setup

extension ImagesViewController {
    
    private func setupVies() {
        addVies()
        setupView()
        setupTableView()
        
        tableViewLayout()
    }
}

// MARK: - Setup Elements

extension ImagesViewController {
    
    private func addVies() {
        view.addSubview(tableView)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImagesCell.self,
                           forCellReuseIdentifier: Constants.identifier)
    }
    
    private func goToImageDetailViewController(indexPath: Int) {
        let id = imagesModel[indexPath].id
        selectId = id
        let vc = Builder.makeImageDetailViewController(id: selectId ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension ImagesViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension ImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier,
                                                       for: indexPath) as? ImagesCell else { return UITableViewCell() }
        
        let imagesModels = imagesModel[indexPath.row]
        cell.set(images: imagesModels)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToImageDetailViewController(indexPath: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == imagesModel.count - 1 {
            setupBinding(page: page)
            page += 1
        }
    }
}

// MARK: - Layout

extension ImagesViewController {
    
    private func tableViewLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
             tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
             tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor)])
    }
}

// MARK: - Constants

extension ImagesViewController {
    
    enum Constants {
        static let identifier: String = "Cell"
    }
    
}
