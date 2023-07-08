//
//  OnboardingViewController.swift
//  OneFootball
//
//  Created by Iskhak Zhutanov on 07.07.23.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let backgroundImages: [UIImage] = [UIImage(named: "messi")!, UIImage(named: "ronaldo")!, UIImage(named: "torres")!, UIImage(named: "spain")!]
        
    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private lazy var indicatorDotsView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var firstIndicatorDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var secondIndicatorDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var thirdIndicatorDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var fourthIndicatorDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        view.addSubview(onboardingCollectionView)
        onboardingCollectionView.snp.makeConstraints { make in
            make.height.width.centerX.equalToSuperview()
        }
        
        view.addSubview(indicatorDotsView)
        indicatorDotsView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalTo(84)
        }
        
        indicatorDotsView.addSubview(firstIndicatorDotView)
        firstIndicatorDotView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.width.equalTo(12)
        }
        
        indicatorDotsView.addSubview(secondIndicatorDotView)
        secondIndicatorDotView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(firstIndicatorDotView.snp.right).offset(12)
            make.height.width.equalTo(12)
        }
        
        indicatorDotsView.addSubview(thirdIndicatorDotView)
        thirdIndicatorDotView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(secondIndicatorDotView.snp.right).offset(12)
            make.height.width.equalTo(12)
        }
        
        indicatorDotsView.addSubview(fourthIndicatorDotView)
        fourthIndicatorDotView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(thirdIndicatorDotView.snp.right).offset(12)
            make.height.width.equalTo(12)
        }
    }
    
    @objc private func nextButtonClicked() {
        let visibleCellIndexPathRow = onboardingCollectionView.indexPathsForVisibleItems.first!.row
        
        if visibleCellIndexPathRow != 3 {
            onboardingCollectionView.scrollToItem(at: IndexPath(row: visibleCellIndexPathRow + 1, section: 0), at: [], animated: false)
        }
        
        switch visibleCellIndexPathRow {
        case 0:
            secondIndicatorDotView.backgroundColor = .systemBackground
            firstIndicatorDotView.backgroundColor = .gray
        case 1:
            thirdIndicatorDotView.backgroundColor = .systemBackground
            secondIndicatorDotView.backgroundColor = .gray
        case 2:
            fourthIndicatorDotView.backgroundColor = .systemBackground
            thirdIndicatorDotView.backgroundColor = .gray
        default:
            ()
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        cell.backgroundImageView.image = backgroundImages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == 3 {
            let lastCell = cell as! OnboardingCollectionViewCell
            
            lastCell.nextButton.setTitle("Start", for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
