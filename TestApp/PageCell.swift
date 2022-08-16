//
//  PageCell.swift
//  TestApp
//
//  Created by Leysan Latypova on 16.08.2022.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            bearPawImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(
                string: unwrappedPage.headerText,
                attributes: [NSAttributedString.Key.font:
                                UIFont.boldSystemFont(ofSize: 18)]
            )
            attributedText.append(
                NSAttributedString(
                    string: unwrappedPage.bodyText,
                    attributes: [NSAttributedString.Key.font:
                                    UIFont.systemFont(ofSize: 14),
                                 NSAttributedString.Key.foregroundColor:
                                    UIColor.gray]
                )
            )
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let bearPawImageView: UIImageView = {
        let bearImage = UIImage(named: "bear_first")
        let imageView = UIImageView(image: bearImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(
            string: "Join us",
            attributes: [NSAttributedString.Key.font:
                            UIFont.boldSystemFont(ofSize: 18)]
        )
        attributedText.append(
            NSAttributedString(
                string: "\n\n\nAnother long-long-long text that goes under the title and specifies whatever you want to specify",
                attributes: [NSAttributedString.Key.font:
                                UIFont.systemFont(ofSize: 14),
                             NSAttributedString.Key.foregroundColor:
                                UIColor.gray]
            )
        )
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let topImageContainerView: UIView = {
        let topImageContainer = UIView()
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
        return topImageContainer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(descriptionTextView)
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(bearPawImageView)
        
        NSLayoutConstraint.activate([
            topImageContainerView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: 0.5
            ),
            topImageContainerView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            topImageContainerView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            topImageContainerView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            )
        ])
       
        NSLayoutConstraint.activate([
            bearPawImageView.centerXAnchor.constraint(
                equalTo: topImageContainerView.centerXAnchor
            ),
            bearPawImageView.centerYAnchor.constraint(
                equalTo: topImageContainerView.centerYAnchor
            ),
            bearPawImageView.heightAnchor.constraint(
                equalTo: topImageContainerView.heightAnchor,
                multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(
                equalTo: topImageContainerView.bottomAnchor
            ),
            descriptionTextView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            descriptionTextView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            descriptionTextView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: 0
            )
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

