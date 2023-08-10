//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by emersonsiega on 10/08/23.
//

import Foundation

class SchoolsViewModel {
    private let apiService: SchoolAPILogic = SchoolAPI()
    
    private(set) var schools: [School] = []
    private(set) var error: DataError? = nil
    
    func getSchools(completion: @escaping( ([School]?, DataError? ) -> Void )) {
        apiService.getSchools { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools ?? []
                completion(schools, nil)
            case .failure(let error):
                self?.error = error
                completion([], error)
            }
        }
    }
}
