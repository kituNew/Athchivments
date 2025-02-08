//
//  ViewController.swift
//  Atchivents
//
//  Created by Zaitsev Vladislav on 05.02.2025.
//

import UIKit

private enum UserInfo {
    static let name = "Виктор Лопаткин"
    static let bio = "Ну, наверное, в описании не нуждается"
}

private enum UIConstants {
    static let cardCornerRadius: CGFloat = 32
    static let cardShadowOpacity: Float = 0.1
    static let cardShadowRadius: CGFloat = 8
    static let cardShadowOffset: CGSize = CGSize(width: 0, height: -3)
    
    static let collectionItemSize: CGSize = CGSize(width: 150, height: 150)
    static let collectionMinimumInteritemSpacing: CGFloat = 12
    static let collectionMinimumLineSpacing: CGFloat = 16
    static let collectionSectionInset: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    
    static let profileStackSpacing: CGFloat = 16
    static let profileStackPadding: CGFloat = 24
    static let avatarImageSize: CGFloat = 80
    
    static let cardDefaultBottomConstant: CGFloat = 50
    static let collectionHiddenAlpha: CGFloat = 0
    
    static let leadengInset: CGFloat = 16
    static let cardViewHeight: CGFloat = 200
    
    static let keyForGetWindow: String = "currentWindow"
}

var currentWindow: String?

class ProfileViewController: UIViewController {
    private var cardBottomConstraint: NSLayoutConstraint!
    private var collectionViewTopConstraint: NSLayoutConstraint!
    private var isCarColabsed: Bool = true
    
    private let atcivments = Atcivment.demoData
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = UIConstants.cardCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = UIConstants.cardShadowOpacity
        view.layer.shadowRadius = UIConstants.cardCornerRadius
        view.layer.shadowOffset = UIConstants.cardShadowOffset
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIConstants.collectionItemSize
        layout.minimumInteritemSpacing = UIConstants.collectionMinimumInteritemSpacing
        layout.minimumLineSpacing = UIConstants.collectionMinimumLineSpacing
        layout.sectionInset = UIConstants.collectionSectionInset
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.name
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.bio
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.alpha = UIConstants.collectionHiddenAlpha
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("1", forKey: UIConstants.keyForGetWindow)
        view.backgroundColor = .systemCyan
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        let profileStackView = UIStackView(arrangedSubviews: [avatarImageView, nameLabel, bioLabel])
        profileStackView.axis = .vertical
        profileStackView.spacing = UIConstants.profileStackSpacing
        profileStackView.alignment = .center
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(profileStackView)
        view.addSubview(cardView)
        view.addSubview(collectionView)
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardTap)))
        
        let nameLabelHeight = nameLabel.intrinsicContentSize.height
        let stackViewBottomPadding: CGFloat = 16
        let initialCardPosition: CGFloat = -(nameLabelHeight + stackViewBottomPadding + view.safeAreaInsets.bottom)
        cardBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: initialCardPosition)
        collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.cardViewHeight)
        
        NSLayoutConstraint.activate([
            cardBottomConstraint,
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.leadengInset),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.leadengInset),
            cardView.heightAnchor.constraint(equalToConstant: UIConstants.cardViewHeight),
            
            profileStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: UIConstants.profileStackPadding),
            profileStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -UIConstants.profileStackPadding),
            profileStackView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: UIConstants.avatarImageSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: UIConstants.avatarImageSize),
            
            collectionViewTopConstraint,
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        cardView.layer.zPosition = 1
    }
    
    private func setupCollectionView() {
        collectionView.register(AtcivmentCell.self, forCellWithReuseIdentifier: "AtcivmentCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alpha = UIConstants.collectionHiddenAlpha
    }

    @objc func handleCardTap() {
        isCarColabsed.toggle()
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            if self.isCarColabsed {
                let nameLabelHeight = self.nameLabel.intrinsicContentSize.height
                let stackViewBottomPadding: CGFloat = 16
                let targetPosition: CGFloat = -(nameLabelHeight + stackViewBottomPadding + self.view.safeAreaInsets.bottom)
                self.cardBottomConstraint.constant = targetPosition
            } else {
                self.cardBottomConstraint.constant = -(self.view.frame.height - self.view.safeAreaInsets.top - UIConstants.cardViewHeight)
            }
            
            self.collectionView.transform = self.isCarColabsed
            ? CGAffineTransform(translationX: 0, y: self.view.frame.height / 2)
            : .identity
            self.collectionView.alpha = self.isCarColabsed ? 0 : 1
            
            self.bioLabel.alpha = self.isCarColabsed ? 0 : 1
            
            self.view.layoutIfNeeded()
        }) { _ in
            self.collectionView.isUserInteractionEnabled = !self.isCarColabsed
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return atcivments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AtcivmentCell", for: indexPath) as! AtcivmentCell
        cell.delegate = self
        cell.configure(with: atcivments[indexPath.item])
        return cell
    }
    
    public func makeAlert(descriptionLabel: String?) {
        let alert = UIAlertController(title: "Описание", message: descriptionLabel, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
    
    public func makeViewOfCell (title: String?,
                                description: String?,
                                iconName: UIImage?,
                                color: UIColor?,
                                maxValue: Int?,
                                currentValue: Int?) {
        currentWindow = UserDefaults.standard.value(forKey: UIConstants.keyForGetWindow) as? String ?? ""
        if (currentWindow == "1") {
            let viewOfCellInformation = InformationForCellViewController()
            viewOfCellInformation.modalPresentationStyle = .fullScreen
            viewOfCellInformation.setInformation(title: title,
                                    description: description,
                                    iconName: iconName,
                                    color: color,
                                    maxValue: maxValue,
                                    currentValue: currentValue)
            navigationController?.pushViewController(viewOfCellInformation, animated: true)
            UserDefaults.standard.set(2, forKey: UIConstants.keyForGetWindow)
        }
    }
}

