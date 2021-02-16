//
//  ImagesCell.swift
//  imageTest
//
//  Created by Анна Сычева on 15.02.2021.
//

import UIKit

// MARK: - ImageDetailCell

final class ImagesCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let photoImage = UIImageView()
    private let descriptionLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupVies()
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
        descriptionLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func set(images: ImagesModel) {
        setPhotoImage(images: images)
        setDescriptionLabel(images: images)
    }
    
    // MARK: - Private methods
    
    private func setPhotoImage(images: ImagesModel) {
        let photoImageString = images.urls.small
        guard let url = URL(string: photoImageString) else { return }
        photoImage.load(url: url)
    }
    
    private func setDescriptionLabel(images: ImagesModel) {
        guard let description = images.description else { return
            descriptionLabel.text = Constants.defaultText }
        descriptionLabel.text = description
    }
}

// MARK: - Setup

extension ImagesCell {
    
    private func setupVies() {
        addVies()
        setupPhotoImageView()
        setupDescriptionLabel()
        
        descriptionLabelLayout()
        photoImageLayout()
    }
}

// MARK: - Setup Elements

extension ImagesCell {
    
    private func addVies() {
        contentView.addSubview(photoImage)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupPhotoImageView() {
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 5
    }
}

// MARK: - Layout

extension ImagesCell {
    
    private func photoImageLayout() {
        
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [photoImage.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 10),
             photoImage.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -10),
             photoImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
             photoImage.widthAnchor.constraint(
                equalToConstant: 100),
             photoImage.heightAnchor.constraint(
                equalToConstant: 150)])
    }
    
    private func descriptionLabelLayout() {
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [descriptionLabel.topAnchor.constraint(
                equalTo: photoImage.topAnchor),
             descriptionLabel.bottomAnchor.constraint(
                equalTo: photoImage.bottomAnchor),
             descriptionLabel.leadingAnchor.constraint(
                equalTo: photoImage.trailingAnchor, constant: 20),
             descriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20)])
    }
}

// MARK: - Constants

extension ImagesCell {
    
    enum Constants {
        static let defaultText: String = """
            Фотогра́фия — технология записи изображения путём регистрации оптических излучений с помощью светочувствительного фотоматериала или полупроводникового преобразователя. В отличие от некоторых других языков, в русском слово «фотография» используется только применительно к неподвижным изображениям. В то же время, в профессиональном кинематографе этот термин обозначает изобразительное решение фильма, создаваемое кинооператором. Фотографиями также называются конечные отпечатки фотографического изображения, изготовленные на фотобумаге химическим способом или принтером.
            На технологиях фотографии основано фотоискусство, которое считается одним из видов изобразительного искусства и занимает ключевое место в современной массовой культуре. Первое устойчивое фотографическое изображение было создано в 1822 году французом Жозефом Нисефором Ньепсом, но оно не сохранилось до наших дней[1][2]. Датой изобретения технологии по решению IX Международного конгресса научной и прикладной фотографии считается 7 января 1839 года, когда Франсуа Араго сделал доклад о дагеротипии на заседании Французской академии наук[3][4][5][6].

            Человек, осуществляющий фотосъёмку, называется фотографом. В большинстве случаев он же выполняет все остальные стадии создания фотоизображения, однако часто техническая часть работы выполняется фотолаборантами, ретушёрами, фоторедакторами и представителями других профессий. В профессиональной студийной фотографии некоторые обязанности фотограф перепоручает своим ассистентам.
"""
    }
    
}
