//
//  AtcivmentCell.swift
//  Atchivents
//
//  Created by Zaitsev Vladislav on 05.02.2025.
//

private enum UIConstants {
    static let cornerRadius: CGFloat = 16
    static let shadowOpacity: Float = 0.1
    static let shadowRadius: CGFloat = 4
    static let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let imageHeight: CGFloat = 60
    static let stackSpacing: CGFloat = 8
    static let stackPadding: CGFloat = 8
    static let titleLabelFont: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    static let titleLabelTextColor: UIColor = .black
}

import UIKit

protocol AchievementCellDelegate: AnyObject {
    func handleTap(cell: AchievementCell)
    func handleLongPress(cell: AchievementCell)
}

final class AchievementCell: UICollectionViewCell {
    public var delegate: AchievementCellDelegate?
    private var maxValue: Int = 0
    private var currentValue: Int = 0
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGray
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
    
    private var descriptionLabel: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = UIConstants.cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = UIConstants.shadowOpacity
        layer.shadowRadius = UIConstants.shadowRadius
        layer.shadowOffset = UIConstants.shadowOffset
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.stackPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.stackPadding),
            imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageHeight),
        ])
    }
    
    public func configure(with atcivment: Achievement) {
        titleLabel.text = atcivment.title
        imageView.image = UIImage(systemName: atcivment.iconName)?
            .withRenderingMode(.alwaysTemplate)
        imageView.tintColor = atcivment.currentValue == atcivment.maxValue ? atcivment.color : UIColor.systemGray
        descriptionLabel = atcivment.description
        maxValue = atcivment.maxValue
        currentValue = atcivment.currentValue
    }
    
    @objc private func handleTap(cell: AchievementCell) {
        delegate?.handleTap(cell: self)
    }
    
    @objc private func handleLongPress(cell: AchievementCell) {
        delegate?.handleLongPress(cell: self)
    }
    
    
    
    public func getTitle() -> String {
        return titleLabel.text ?? ""
    }
    
    public func getDescription() -> String {
        return descriptionLabel ?? ""
    }
    
    public func getImage() -> UIImage? {
        return imageView.image
    }
    
    public func getColor() -> UIColor {
        return imageView.tintColor
    }
    
    public func getMaxValue() -> Int {
        return maxValue
    }
    
    public func getCurrentValue() -> Int {
        return currentValue
    }
}
