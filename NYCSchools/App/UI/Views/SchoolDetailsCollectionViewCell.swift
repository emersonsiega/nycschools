//
//  File.swift
//  NYCSchools
//
//  Created by Emerson Siega on 31/10/24.
//

import Foundation
import UIKit

class SchoolDetailsCollectionViewCell: UICollectionViewCell {
    private var school: School?
    
    private struct Constants {
        static let insets: CGFloat = 10
        static let borderWidth: CGFloat = 0.5
        static let cornerRadius: CGFloat = 10
        static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let spacing: CGFloat = 5
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.address.title".localized()
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.email.title".localized()
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.phone.title".localized()
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var academicOpportunitiesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.academicOpportunities.title".localized()
        return label
    }()
    
    private var academicOpportunitiesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var gradesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.grades.title".localized()
        return label
    }()
    
    private var gradesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var websiteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        label.text = "school.details.website.title".localized()
        return label
    }()
    
    private var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var wrapperView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperViewInsets)
    }
    
    private func setupViews() {
        backgroundColor = .white
        setupWrapperView()
        setupStackView()
    }
    
    private func setupStackView() {
        wrapperView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.insets)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constants.insets)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.insets)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.insets)
        
        stackView.addArrangedSubview(nameLabel)
        
        stackView.addArrangedSubview(addressTitleLabel)
        stackView.addArrangedSubview(addressLabel)
        
        stackView.addArrangedSubview(emailTitleLabel)
        stackView.addArrangedSubview(emailLabel)
        
        stackView.addArrangedSubview(phoneTitleLabel)
        stackView.addArrangedSubview(phoneLabel)
        
        stackView.addArrangedSubview(academicOpportunitiesTitleLabel)
        stackView.addArrangedSubview(academicOpportunitiesLabel)
        
        stackView.addArrangedSubview(gradesTitleLabel)
        stackView.addArrangedSubview(gradesLabel)
        
        stackView.addArrangedSubview(websiteTitleLabel)
        stackView.addArrangedSubview(websiteLabel)
    }
    
    func populate(school: School) {
        self.school = school
        
        nameLabel.text = school.schoolName
        
        var addressComponents: [String] = []
        if let city = school.city {
            addressComponents.append(city)
        }
        if let addressLine = school.primaryAddressLine {
            addressComponents.append(addressLine)
        }
        if let zipCode = school.zip {
            addressComponents.append(zipCode)
        }
        addressLabel.text = addressComponents.joined(separator: ", ")
        
        emailLabel.text = school.schoolEmail ?? ""
        phoneLabel.text = school.phoneNumber ?? ""
        
        var opportunities: [String] = []
        if let opt1 = school.academicOpportunities1 {
            opportunities.append(opt1)
        }
        if let opt2 = school.academicOpportunities2 {
            opportunities.append(opt2)
        }
        academicOpportunitiesLabel.text = opportunities.joined(separator: ", ")
        
        gradesLabel.text = school.finalGrades ?? ""
        
        websiteLabel.text = school.website ?? ""
    }
}
