//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by emersonsiega on 10/08/23.
//

import Foundation
import Combine

class SchoolsViewModel {
    private let apiService: SchoolAPILogic
    
    @Published private(set) var schools: [School] = []
    @Published private(set) var error: DataError? = nil
    private (set) var schoolSectionsList: [SchoolSection]?
    
    init(apiService: SchoolAPILogic = SchoolAPI()) {
        self.apiService = apiService
    }
    
    func getSchools() {
        apiService.getSchools { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools ?? []
                if schools?.isEmpty == false {
                    self?.prepareSchoolSections()
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    private func prepareSchoolSections() {
        var listOfSections = [SchoolSection]()
        var schoolDictionary = [String: SchoolSection]()
        
        for school in schools {
            if let city = school.city {
                if schoolDictionary[city] != nil {
                    schoolDictionary[city]!.schools.append(school)
                    continue
                }
                
                schoolDictionary[city] = SchoolSection(city: city, schools: [school])
            }
        }
        
        listOfSections = Array(schoolDictionary.values)
        listOfSections.sort {
            return $0.city < $1.city
        }
        schoolSectionsList = listOfSections
    }
}
