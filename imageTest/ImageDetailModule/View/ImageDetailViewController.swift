//
//  ImageDetailViewController.swift
//  imageTest
//
//  Created by Анна Сычева on 16.02.2021.
//

import UIKit
import Moya

// MARK: - ImageDetailViewController

final class ImageDetailViewController: UIViewController {
    
    // MARK: - Public properties
    
    public var viewModel: IImageDetailViewModel?
    public var networkService: INetworkService?
    
    // MARK: - Private properties
    
    private let provider = MoyaProvider<ImageService>()
    private var imageDetailModel: ImageDetailModel?
    private let fullPhotoImageView = UIImageView()
    private let descriptionLabel = UITextView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVies()
        setupBinding()
    }
}

// MARK: - Setup

extension ImageDetailViewController {
    
    private func setupVies() {
        addVies()
        fullPhotoImageViewLayout()
        descriptionLabelLayout()
    }
    
    private func setupBinding() {
        viewModel?.didWillappear()
        
        DispatchQueue.main.async {
            self.viewModel?.imageDetailDidChange = { [weak self] viewModel in
                guard let self = self else { return }
                self.imageDetailModel = viewModel
                self.setupFullPhotoImageView()
                self.setupView()
                self.setupDescriptionLabel()
            }
        }
    }
}

// MARK: - Setup Elements

extension ImageDetailViewController {
    
    private func addVies() {
        view.addSubview(fullPhotoImageView)
        view.addSubview(descriptionLabel)
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupFullPhotoImageView() {
        guard let fullPhotoString = imageDetailModel?.urls.full else { return }
        guard let url = URL(string: fullPhotoString) else { return }
        fullPhotoImageView.load(url: url)
        fullPhotoImageView.contentMode = .scaleAspectFill
        fullPhotoImageView.clipsToBounds = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        guard let descriptionString = imageDetailModel?.description else { return
            descriptionLabel.text = Constants.defaultText
        }
        descriptionLabel.text = descriptionString
    }
}

extension ImageDetailViewController {
    
    private func fullPhotoImageViewLayout() {
        
        fullPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [fullPhotoImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
             fullPhotoImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
             fullPhotoImageView.widthAnchor.constraint(
                equalToConstant: 300),
             fullPhotoImageView.heightAnchor.constraint(
                equalToConstant: 400)])
    }
    
    private func descriptionLabelLayout() {
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [descriptionLabel.topAnchor.constraint(
                equalTo: fullPhotoImageView.bottomAnchor, constant: 20),
             descriptionLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
             descriptionLabel.leadingAnchor.constraint(
                equalTo: fullPhotoImageView.leadingAnchor),
             descriptionLabel.trailingAnchor.constraint(
                equalTo: fullPhotoImageView.trailingAnchor),
             descriptionLabel.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)])
    }
}

// MARK: - Constants

extension ImageDetailViewController {
    
    enum Constants {
        static let defaultText: String = """
            Фотогра́фия — технология записи изображения путём регистрации оптических излучений с помощью светочувствительного фотоматериала или полупроводникового преобразователя. В отличие от некоторых других языков, в русском слово «фотография» используется только применительно к неподвижным изображениям. В то же время, в профессиональном кинематографе этот термин обозначает изобразительное решение фильма, создаваемое кинооператором. Фотографиями также называются конечные отпечатки фотографического изображения, изготовленные на фотобумаге химическим способом или принтером.
            На технологиях фотографии основано фотоискусство, которое считается одним из видов изобразительного искусства и занимает ключевое место в современной массовой культуре. Первое устойчивое фотографическое изображение было создано в 1822 году французом Жозефом Нисефором Ньепсом, но оно не сохранилось до наших дней[1][2]. Датой изобретения технологии по решению IX Международного конгресса научной и прикладной фотографии считается 7 января 1839 года, когда Франсуа Араго сделал доклад о дагеротипии на заседании Французской академии наук[3][4][5][6].

            Человек, осуществляющий фотосъёмку, называется фотографом. В большинстве случаев он же выполняет все остальные стадии создания фотоизображения, однако часто техническая часть работы выполняется фотолаборантами, ретушёрами, фоторедакторами и представителями других профессий. В профессиональной студийной фотографии некоторые обязанности фотограф перепоручает своим ассистентам.
"""
    }
    
}
