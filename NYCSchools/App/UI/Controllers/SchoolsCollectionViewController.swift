//
//  ViewController.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import UIKit
import Combine
import PureLayout

class SchoolsCollectionViewController: UIViewController {
    private let schoolsViewModel = SchoolsViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var collectionView: UICollectionView?
    
    private struct Constants {
        static let cellIdentifier:String = "schoolCell"
        static let cellHeight: CGFloat = 100
        static let sectionHeaderIdentifier: String = "sectionHeader"
        static let sectionHeight: CGFloat = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBinders()
        schoolsViewModel.getSchools()
        
        //TODO: Remove!!
        let title = "schools.title".localized()
        print("localization usage example: \(title)")
    }
    
    private func setupCollectionView() {
        let collectionViewlayout = UICollectionViewFlowLayout()
        collectionViewlayout.itemSize = CGSize(width: view.frame.size.width,
                                               height: Constants.cellHeight)
        collectionViewlayout.headerReferenceSize = CGSize(width: view.frame.size.width,
                                                          height: Constants.sectionHeight)
        collectionViewlayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame,
                                          collectionViewLayout: collectionViewlayout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
        // Setup and customize flow layout
        collectionView.register(SchoolCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.cellIdentifier)
        collectionView.register(SchoolsSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Constants.sectionHeaderIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupBinders() {
        schoolsViewModel.$schools
            .receive(on: RunLoop.main)
            .sink { [weak self] schools in
                if !schools.isEmpty {
                    print("Retrieved \(schools.count) schools")
                    self?.collectionView?.reloadData()
                }
            }
            .store(in: &cancellables)
        
        schoolsViewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(
                        title: "Error",
                        message: "Could not retrieve schools. \(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    
                    self?.present(alert, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
}

extension SchoolsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schoolsViewModel.schoolSectionsList?[section].schools.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath) as? SchoolCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let schoolSection = schoolsViewModel.schoolSectionsList?[indexPath.section] {
            let school = schoolSection.schools[indexPath.item]
            cell.populate(school)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader,
           let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.sectionHeaderIdentifier,
                for: indexPath) as? SchoolsSectionHeaderView  {
            sectionHeader.headerLabel.text = schoolsViewModel.schoolSectionsList?[indexPath.section].city
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return schoolsViewModel.schoolSectionsList?.count ?? 1
    }
}

extension SchoolsCollectionViewController: UICollectionViewDelegate {
    
}

