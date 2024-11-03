//
//  SchoolDetailsViewController.swift
//  NYCSchools
//
//  Created by Emerson Siega on 31/10/24.
//

import Foundation
import UIKit

class SchoolDetailsViewController: UIViewController {
    private var sectionsList: [String] = ["school.details.section".localized()]
    private var collectionView: UICollectionView?
    
    var viewModel: SchoolDetailsViewModel?
    
    private struct Constants {
        static let schoolDetailsCellIdentifier: String = "schoolDetailsCell"
        static let detailsCellHeight: CGFloat = 360
        static let sectionHeaderIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.school.schoolName ?? ""
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width,
                                               height: Constants.detailsCellHeight)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width,
                                                          height: Constants.sectionHeight)
        collectionViewLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame,
                                         collectionViewLayout: collectionViewLayout)
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(SchoolDetailsCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.schoolDetailsCellIdentifier)
        
        collectionView.register(SchoolsSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Constants.sectionHeaderIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SchoolDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.schoolDetailsCellIdentifier, for: indexPath)
            guard let schoolDetailsCell = cell as? SchoolDetailsCollectionViewCell,
                  let school = viewModel?.school else {
                return cell
            }
            schoolDetailsCell.populate(school: school)
            return schoolDetailsCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.sectionHeaderIdentifier,
                for: indexPath) as? SchoolsSectionHeaderView  {
            sectionHeader.headerLabel.text = sectionsList[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension SchoolDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constants.detailsCellHeight)
    }
}

extension SchoolDetailsViewController: UICollectionViewDelegate {
    
}
