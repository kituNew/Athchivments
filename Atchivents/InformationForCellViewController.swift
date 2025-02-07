//
//  InformationForCellViewController.swift
//  Atchivents
//
//  Created by Zaitsev Vladislav on 07.02.2025.
//

import UIKit

private enum UIConstants {
    static let cornerRadius: CGFloat = 16
    static let shadowOpacity: Float = 0.1
    static let shadowRadius: CGFloat = 4
    static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let imageHeight: CGFloat = 60
    static let stackSpacing: CGFloat = 8
    static let stackPadding: CGFloat = 100
    static let titleLabelFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    static let titleLabelTextColor: UIColor = .black
}

class InformationForCellViewController: UIViewController {
    
    var maxValue: Int = 1
    var currentValue: Int = 0
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = UIConstants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = UIConstants.shadowOpacity
        view.layer.shadowRadius = UIConstants.cornerRadius
        view.layer.shadowOffset = UIConstants.shadowOffset
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleLabelFont
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIConstants.titleLabelTextColor
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleLabelFont
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIConstants.titleLabelTextColor
        return label
    }()
    
    private var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        //progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        showCell()
    }
    
    func showCell() {
        progressView.progress = Float(currentValue) / Float(maxValue)
        let stackView = UIStackView(arrangedSubviews: [progressView, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        cardView.addSubview(stackView)
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.imageHeight + 35),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.stackPadding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.stackPadding),
            
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.imageHeight + 90),
            cardView.heightAnchor.constraint(equalToConstant: 150),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.stackPadding/2),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.stackPadding/2),
            
            stackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
    
    func setInformation
    (
        title: String?,
        description: String?,
        iconName: UIImage?,
        color: UIColor?,
        maxValue: Int?,
        currentValue: Int?
    ) {
        titleLabel.text = title
        imageView.image = iconName
        imageView.tintColor = color
        descriptionLabel.text = description
        self.maxValue = maxValue ?? 1
        self.currentValue = currentValue ?? 0
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set("1", forKey: "currentWindow")
    }
}
