//
//  SwipingController.swift
//  TestApp
//
//  Created by Leysan Latypova on 16.08.2022.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static var secondaryPink = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
}

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(
            imageName: "bear_first",
            headerText: "Join us today in our fun and games!",
            bodyText: "\n\n\nAnother long-long-long text that goes under the title and specifies whatever you want to specify"),
        Page(
            imageName: "heart_second",
            headerText: "Subscribe and get coupons",
            bodyText: "\n\n\nAnd another long-long-long text that goes under the title and specifies whatever you want to specify"),
        Page(
            imageName: "leaf_third",
            headerText: "Do something and be happy!",
            bodyText: "\n\n\nYet another long-long-long text that goes under the title and specifies whatever you want to specify")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .secondaryPink
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.isPagingEnabled = true
        setupBottomControls()
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } completion: { _ in
        }
    }
    
    @objc private func handlePrevious() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillProportionally
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
  
}
