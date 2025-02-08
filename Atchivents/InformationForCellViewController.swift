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
    
    static let cardViewHeight: CGFloat = 150
    static let cardViewDownForImage: CGFloat = 150
    static let cardViewPadding: CGFloat = 50
    static let imageDovnForView: CGFloat = 185
    static let stackLeftPadding: CGFloat = 20
    
    static let keyForGetWindow: String = "currentWindow"
}

final class InformationForCellViewController: UIViewController {
    
    private var maxValue: Int = 1
    private var currentValue: Int = 0
    
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.titleLabelFont
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIConstants.titleLabelTextColor
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        return progressView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        showCell()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set("1", forKey: UIConstants.keyForGetWindow)
    }
    
    private func showCell() {
        progressView.progress = Float(currentValue) / Float(maxValue)
        [progressView, titleLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(imageView)
        cardView.addSubview(stackView)
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.imageDovnForView),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.stackPadding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.stackPadding),
            
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.cardViewDownForImage),
            cardView.heightAnchor.constraint(equalToConstant: UIConstants.cardViewHeight),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.cardViewPadding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.cardViewPadding),
            
            stackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.stackLeftPadding),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.stackLeftPadding),
        ])
    }
}

extension InformationForCellViewController {
    public func setInformation (cell: AchievementCell) {
        titleLabel.text = cell.getTitle()
        imageView.image = cell.getImage()
        imageView.tintColor = cell.getCollor()
        descriptionLabel.text = cell.getDescription()
        self.maxValue = cell.getMaxValue()
        self.currentValue = cell.getCurrentValue()
    }
}
